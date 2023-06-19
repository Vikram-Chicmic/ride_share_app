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
    @Published var successUpdate: Bool = false
    @Published var navigate: Bool = false
    @Published var navigateToForm = false
    @Published var isUpdating = false
    @Published var bio = ""
    @Published var travelPreference = ""
    @Published var postalAddress = ""
    @Published var passcode = ""
    @Published var sendOTP = false
    @Published var verified = false
    @Published var showAlertSignUpProblem = false
    @Published var failtToSendOtpAlert = false
    var userLoggedIn: Bool {
        return UserDefaults.standard.bool(forKey: Constants.Url.userLoggedIN)
    }
    @Published var isLoading = false
    
//    @Published var userLoggedIn = UserDefaults.standard.bool(forKey: Constants.Url.userLoggedIN)
    enum Title: String, CaseIterable {
         case mr = "Mr."
         case miss = "Miss."
         case mrs = "Mrs."
     }
    
    @Published var formIsValid = false
    @Published var isUserEmailValid = false
    @Published var isUserPasswordValid = false
    @Published var updateAlertProblem = false
    
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
    
    
    // MARK: encode recieved data
    func encodeData(recievedData: Welcome){
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(recievedData) {
            UserDefaults.standard.set(encodedData, forKey: "UserDataKey")
        }
    }
    
    // MARK: decode recived data
    func decodeData() {
        if let storedData = UserDefaults.standard.data(forKey: "UserDataKey"),
           let decodedData = try? JSONDecoder().decode(Welcome.self, from: storedData) {
            // Use the decodedData as needed
            self.recievedData = decodedData
    
        }

    }
    
    // MARK: - Sign-Up

    func signUp() {
        guard let url = URL(string: Constants.Url.signUpUrl) else { return }
        self.isLoading = true
        let userData: [String: Any]
        if isUpdating {
            userData = [
                Constants.Url.fname: fname,
                Constants.Url.lname: lname,
                Constants.Url.dob: bday,
                Constants.Url.title: selectedTitle,
                Constants.Url.bio: bio,
                Constants.Url.travelPreference: travelPreference,
                Constants.Url.postalAddress: postalAddress
            ] as [String: Any]
        } else {
            userData = [
                Constants.Url.email: email,
                Constants.Url.password: password,
                Constants.Url.fname: fname,
                Constants.Url.lname: lname,
                Constants.Url.dob: bday,
                Constants.Url.title: selectedTitle
                ]
        }
        
      
        
        print(userData)
        
        let jsonData = try? JSONSerialization.data(withJSONObject: [Constants.JsonKey.user: userData], options: [])
        if let jsonData = jsonData {
            print(jsonData)
        } else {
         
            return
        }
        
        
        
        var request = URLRequest(url: url)
        request.httpMethod = isUpdating ? Constants.Methods.put : Constants.Methods.post
        print(request.httpMethod)
        request.httpBody = jsonData
        request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
        
        let decoder = JSONDecoder()
        if let jsonData = jsonData {
            do {
                let sendData = try decoder.decode(SendDataDecode.self, from: jsonData)
                print(sendData)
            } catch {
                print(Constants.Errors.decodeerror)
            }
        } else {}
        
        if let token = UserDefaults.standard.string(forKey: Constants.Url.token) {
            request.setValue(token, forHTTPHeaderField: Constants.Url.auth)
        } else {
            // Key not found or value not a String
        }

        
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
                    UserDefaults.standard.set( true, forKey: Constants.Url.userLoggedIN)
                    if self.isUpdating {
                        self.successUpdate.toggle()
                    }
                    self.navigate.toggle()
                    self.alert.toggle()
                    print(httpResponse.statusCode)
                } else {    
                   
                    if self.isUpdating {
                        self.updateAlertProblem.toggle()
                    }
                    else {
                        self.showAlertSignUpProblem = true
                    }
              
                    print(httpResponse.statusCode)
                }
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                        print(json)
                                    }
                return data
            }
            .decode(type: Welcome.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { decodedData in
                print(decodedData)
                // Assuming you have the JSON data stored in a variable called jsonData
                self.encodeData(recievedData: decodedData)
                self.decodeData()

            })
            .store(in: &publishers)
    }

    // MARK: - CheckEmail

func checkEmail() {
   guard let url = URL(string: Constants.Url.checkEmail+"?email=\(email)") else {
            return
        }
        self.isLoading = true
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = Constants.Methods.get

        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                print(httpResponse.statusCode)
                
  
                
                if httpResponse.statusCode == 204 {
                        self.navigateToForm.toggle()
                    
                } else if httpResponse.statusCode == 422 {
                    self.showAlert.toggle()
                } else {
                    print(Constants.Errors.unexpected)
                }
                
                return data
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
            }, receiveValue: { data in
                
            })
            .store(in: &publishers)
    }

 

    // MARK: - Login
    
    func login() {
        guard let url = URL(string: Constants.Url.loginUrl) else {
            print(Constants.Error.invalidUrl)
            return
        }
        
        self.isLoading = true
        
        let userData = [
            Constants.Url.email: email,
            Constants.Url.password: password
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: [Constants.JsonKey.user: userData], options: [])
        
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
                } else if httpResponse.statusCode == 404 {
                    self.showAlert.toggle()
                }
                else {
                    print(httpResponse.statusCode)
                    self.showAlert = true
                }
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                        print(json)
                                    }
                return data
            }
            .decode(type: Welcome.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { decodedData in
                // MARK: encode recieved data and store in userDefaults
//                print("Recieved Data :\(decodedData)")
                self.encodeData(recievedData: decodedData)
                self.decodeData()
            })
            .store(in: &publishers)
    }

    // MARK: - Logout
    func logoutUser() {
        guard let url = URL(string: Constants.Url.signOutUrl) else {
            print("Invalid URL")
            return
        }
        self.isLoading = true
        var request = URLRequest(url: url)
        request.httpMethod = Constants.Methods.delete

        if let token = UserDefaults.standard.string(forKey: Constants.Url.token) {
            request.setValue(token, forHTTPHeaderField: Constants.Url.auth)
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
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { response in
                if response.statusCode == 200 {
                    print(Constants.Errors.signOut)
                    UserDefaults.standard.set(false, forKey: Constants.UserDefaultsKeys.userLoggedIn)
                    UserDefaults.standard.removeObject(forKey: Constants.Url.token)
//                   MARK: Assign empty data to userdefault so that when user relogin it must be assign by new value without data confiction
                    UserDefaults.standard.removeObject(forKey: Constants.UserDefaultsKeys.userDataKey)
                } else {
                    //TODO: - alert
                    print("Failed: \(response.statusCode)")
                }
            })
            .store(in: &publishers)
    }

    // MARK: - Update User
    func updateUser() {
        
    }

    // MARK: - Get user
    func getUser() {
        guard let baseURL = URL(string: Constants.Url.signUpUrl) else {
            return
        }
        
    
        self.isLoading = true
        var request = URLRequest(url: baseURL)
        request.httpMethod = Constants.Methods.get
        
        if let token = UserDefaults.standard.object(forKey: Constants.Url.token) as? String {
            request.setValue(token, forHTTPHeaderField: Constants.Url.auth)
        } else {
            // Key not found or value not a String
        }
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                // Check if the response is successful
                if (200...299).contains(httpResponse.statusCode) {
                    // Handle the received data
                    // Assuming you have a decoder and a data model for the user information
                    let decoder = JSONDecoder()
                    let user = try decoder.decode(Welcome.self, from: data)
                    print("\(user)")
                } else {
                    // Handle the error response
                    print("Error response: \(httpResponse.statusCode)")
                }
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                                        print(json)
                                                    }
                return data
            }
            .receive(on: RunLoop.main)
            .decode(type: Welcome.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { decodedData in
                // Handle the received value if needed
                print("Received data: \(decodedData)")
                self.recievedData = decodedData
                print(self.recievedData)
               
            })
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
        self.isLoading = true
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
        
     
        if let token = UserDefaults.standard.object(forKey: Constants.Url.token) as? String {
            request.setValue(token, forHTTPHeaderField: Constants.Url.auth)
        } else {
            // Key not found or value not a String
        }
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
                        self.failtToSendOtpAlert.toggle()
                }
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print(json)
                }
                
                return data
            }
//            .decode(type: Welcome.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { decodedData in
//                self.recievedData = decodedData
                print(decodedData)
            })
            .store(in: &publishers)

    }
}
