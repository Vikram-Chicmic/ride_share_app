//
//  LoginSignupViewModel.swift
//  BlaBalApp
//
//  Created by ChicMic on 10/05/23.
//

import Foundation
import Combine

class LoginSignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var fname: String = ""
    @Published var lname: String = ""
    @Published var bday: String = ""
    @Published var selectedTitle: String = ""
    @Published var phoneNumber: String = ""
    @Published var step: Int = 0
    @Published var alert: Bool = false
    @Published var recievedData: Welcome?
    @Published var showAlert: Bool = false
    @Published var navigate: Bool = false
    @Published var navigateToForm = false
    @Published var isUpdating = false
    @Published var bio = ""
    @Published var travelPreference = ""
    @Published var postalAddress = ""
    @Published var passcode = ""
    @Published var sendOTP = false
    @Published var verified = false
    var userLoggedIn: Bool {
        return UserDefaults.standard.bool(forKey: Constants.Url.userLoggedIN)
    }
    
//    @Published var userLoggedIn = UserDefaults.standard.bool(forKey: Constants.Url.userLoggedIN)
    enum Title: String, CaseIterable {
         case mr = "Mr."
         case miss = "Miss."
         case mrs = "Mrs."
     }
    
    @Published var formIsValid = false
    @Published var isUserEmailValid = false
    @Published var isUserPasswordValid = false
    
    
    static var authorizationToken = ""
    
    private var publishers = Set<AnyCancellable>()
    
    init() {
        isSignupFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.formIsValid, on: self)
            .store(in: &publishers)
        
        isUserPasswordValidPublisher
                   .receive(on: RunLoop.main)
                   .assign(to: \.isUserPasswordValid, on: self)
                   .store(in: &publishers)
        
        isUserEmailValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isUserEmailValid, on: self)
            .store(in: &publishers)
    }
    
    // MARK: - Validations
    
    var isUserEmailValidPublisher: AnyPublisher<Bool, Never> {
        $email
            .map { email in
                let emailPredicate = NSPredicate(format: Constants.Validations.emailFormat, Constants.Validations.emailValidation)
                return emailPredicate.evaluate(with: email)
            }
            .eraseToAnyPublisher()
    }
    
    var isUserPasswordValidPublisher: AnyPublisher<Bool, Never> {
        $password
            .map { password in
                return password.count >= 8 && password.count <= 20 && password.range(of: Constants.Validations.passwordValidation, options: .regularExpression) != nil
            }
            .eraseToAnyPublisher()
    }

     func loginCheck() -> Bool {
         if isUserEmailValid && isUserPasswordValid {
             return true
         }
         return false
     }
    
    var isSignupFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isUserEmailValidPublisher, isUserPasswordValidPublisher)
            .map { isEmailValid, isPasswordValid in
                return isEmailValid && isPasswordValid
            }
            .eraseToAnyPublisher()
    }
    
   
    // MARK: DecodeResponse
    func decodeResponse<T: Decodable>(data: Data, responseType: T.Type) -> T? {
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(responseType, from: data)
            return decodedData
        } catch {
            print("Error decoding response: \(error.localizedDescription)")
            return nil
        }
    }
    
    
    // MARK: - Sign-Up

    func signUp() {
        guard let url = URL(string: Constants.Url.signUpUrl) else { return }
        
        let userData = [
            Constants.Url.email: email,
            Constants.Url.password: password,
            Constants.Url.fname: fname,
            Constants.Url.lname: lname,
            Constants.Url.dob: bday,
            Constants.Url.title: selectedTitle,
            Constants.Url.phnnumber: Int(phoneNumber) ?? 0,
            Constants.Url.bio: bio,
            Constants.Url.travelPreference: travelPreference,
            Constants.Url.postalAddress: postalAddress
        ] as [String: Any]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: ["user": userData], options: [])
        if let jsonData = jsonData {
            print(jsonData)
        } else {
            print("Cannot convert data to JSON")
            return
        }
        
        
        
        var request = URLRequest(url: url)
        request.httpMethod = isUpdating ? Constants.Methods.put : Constants.Methods.post
        request.httpBody = jsonData
        request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                if let authorization = httpResponse.value(forHTTPHeaderField: Constants.Url.auth) {
                    print("Authorization: \(authorization)")
                    LoginSignUpViewModel.authorizationToken = authorization
                    UserDefaults.standard.set(authorization, forKey: Constants.Url.token)
                }
                
                
                
                if (200...299).contains(httpResponse.statusCode) {
                    UserDefaults.standard.set(self.isUpdating ? false : true, forKey: Constants.Url.userLoggedIN)
                    self.navigate = true
                    print(httpResponse.statusCode)
                } else {    
                    self.showAlert = true
                    print(httpResponse.statusCode)
                }
                
                return data
            }
            .decode(type: Welcome.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { decodedData in
                print(decodedData)
                self.recievedData = decodedData
            })
            .store(in: &publishers)
    }

    // MARK: - CheckEmail

    func checkEmail() {
        guard let url = URL(string: Constants.Url.checkEmail+"?email=\(email)") else {
            return
        }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = Constants.Methods.get

        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> (Int, Data) in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                print(httpResponse.statusCode)
                return (httpResponse.statusCode, data)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { statusCode, _ in
                if statusCode == 204 {
                    self.navigateToForm = true
                    print("Success: Email not exists")
                } else if statusCode == 422 {
                    self.showAlert.toggle()
                    print("Error: Email exist")
                } else {
                    print("Unexpected response")
                }
            })
            .store(in: &publishers)
    }

    // MARK: - Login
    
    func login() {
        guard let url = URL(string: Constants.Url.loginUrl) else {
            print(Constants.Error.invalidUrl)
            return
        }
        
        let userData = [
            Constants.Url.email: email,
            Constants.Url.password: password
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: ["user": userData], options: [])
        
        var request = URLRequest(url: url)
        request.httpMethod = Constants.Methods.post
        request.httpBody = jsonData
        request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                if let authorization = httpResponse.value(forHTTPHeaderField: Constants.Url.auth) {
                    print("Authorization: \(authorization)")
                    UserDefaults.standard.set(authorization, forKey: Constants.Url.token)
                    LoginSignUpViewModel.authorizationToken = authorization
                }
                
                if (200...299).contains(httpResponse.statusCode) {
                    UserDefaults.standard.set(true, forKey: Constants.Url.userLoggedIN)
                    print(httpResponse.statusCode)
                    DispatchQueue.main.async {
                        self.navigate.toggle()
                    }
                   
                } else {
                    print(httpResponse.statusCode)
                    self.showAlert = true
                }
                return data
            }
            .decode(type: Welcome.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { decodedData in
                self.recievedData = decodedData
                print(decodedData)
            })
            .store(in: &publishers)
    }

    // MARK: - Logout
    func logoutUser() {
        guard let url = URL(string: Constants.Url.signOutUrl) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        if let token = UserDefaults.standard.object(forKey: "Token") as? String {
            request.setValue(token, forHTTPHeaderField: "Authorization")
        } else {
            // Key not found or value not a String
        }

        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap {_, response -> HTTPURLResponse in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                return httpResponse
            }
            .receive(on: DispatchQueue.main) // Ensure the following code executes on the main queue
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { response in
                if response.statusCode == 200 {
                    print("Signed Out successfully")
                    UserDefaults.standard.set(false, forKey: "userLoggedIn")
                } else {
                    print("Failed to logout user, status code: \(response.statusCode)")
                }
            })
            .store(in: &publishers)
    }

    // MARK: - Update User
    func updateUser() {
        
    }

    // MARK: - Get user
    func getUser() {
        guard let url = URL(string: Constants.Url.signUpUrl+"?email=\(email)") else {
            return
        }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = Constants.Methods.get

        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: Welcome.self, decoder: JSONDecoder())
            .sink { (completiion) in
                print("Completion: \(completiion)")
            } receiveValue: { [weak self] user in
                self?.recievedData = user
                print(user)
            }
            .store(in: &publishers)
    }
    
    
   

    
    
    // MARK: Phone Verify
    func phoneVerify() {
        var phoneurl: URL?
        if sendOTP {
            phoneurl = URL(string: Constants.Url.sendOTP)
        } else {
           phoneurl = URL(string: Constants.Url.phoneVerify)
        }
        
        guard let url = phoneurl else {
            print(Constants.Error.invalidUrl)
            return
        }
        
        var userData: [String: Any]?
        if !sendOTP {
             userData = [
                Constants.Url.phnnumber: phoneNumber,
                Constants.Url.passcode: passcode
            ]
        } else {
             userData = [
                Constants.Url.phnnumber: phoneNumber
            ]
        }
        
        let jsonData = try? JSONSerialization.data(withJSONObject: userData as Any, options: [])
        
        var request = URLRequest(url: url)
        request.httpMethod = Constants.Methods.post
        request.httpBody = jsonData
        request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                
                if (200...299).contains(httpResponse.statusCode) {
//                    UserDefaults.standard.set(true, forKey: Constants.Url.userLoggedIN)
                    print(httpResponse.statusCode)
                    self.verified = true
                } else {
                    print(httpResponse.statusCode)
                    DispatchQueue.main.async {
                        self.alert = true
                    }
                 
                }
                
                return data
            }.decode(type: Welcome.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { decodedData in
                self.recievedData = decodedData
                print(decodedData)
            })
            .store(in: &publishers)

    }
}
