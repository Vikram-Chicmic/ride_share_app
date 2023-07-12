//
//  LoginSignupViewModel.swift
//  BlaBalApp
//
//  Created by ChicMic on 10/05/23.
//

import Foundation
import Combine

class LoginSignUpViewModel: ObservableObject {
    
    
    static var shared = LoginSignUpViewModel()

    // Variables for store data from views
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var fname: String = ""
    @Published var lname: String = ""
    @Published var bday: String = ""
    @Published var selectedTitle: String = ""
    @Published var phoneNumber: String = ""
    @Published var bio = ""
    @Published var travelPreference = ""
    @Published var postalAddress = ""
    @Published var passcode = ""
    @Published var failAlert = false
    @Published var failToLogout = false
    @Published var failToFetchUser = false
    // Variable for show form view and custom progressBar
    @Published var step: Int = 0
    
    // Variables for alerts
    @Published var alert: Bool = false
    @Published var showAlert: Bool = false
    @Published var successUpdate: Bool = false
    @Published var navigate: Bool = false
    @Published var navigateToForm = false
    @Published var isUpdating = false
    @Published var sendOTP = false
    @Published var verified = false
    @Published var showAlertSignUpProblem = false
    @Published var failtToSendOtpAlert = false
    @Published var userId : Int = 0
    // Variable to store data response
    @Published var recievedData: Welcome?
    @Published var decodedData: DecodeUser?

    var userLoggedIn: Bool {
        return UserDefaults.standard.bool(forKey: Constants.Url.userLoggedIN)
    }
    
    // Variable for progresView
    @Published var isLoading = false
    
    // Variables for validations
    @Published var formIsValid = false
    @Published var isUserEmailValid = false
    @Published var isUserPasswordValid = false
    @Published var updateAlertProblem = false
    @Published var isFirstNameAndLastNameValid = false
    
    static var authorizationToken = ""
    
    // MARK: variables for password updation
    @Published var oldPassword = ""
    @Published var newPassword = ""
    @Published var confirmNewPassword = ""
    @Published var passwordChangeSuccessAlert: Bool = false
    @Published var passwordChangeFailAlert: Bool = false
    
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
    
    // MARK: - Validations (Computed Properties)
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
    func encodeData(recievedData: Welcome) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(recievedData) {
            UserDefaults.standard.set(encodedData, forKey: Constants.UserDefaultsKeys.userDataKey)
        }
    }
    
    // MARK: decode recived data
    func decodeData() {
        if let storedData = UserDefaults.standard.data(forKey: Constants.UserDefaultsKeys.userDataKey),
           let decodedData = try? JSONDecoder().decode(Welcome.self, from: storedData) {
            // Use the decodedData as needed
            self.recievedData = decodedData
    
        }

    }

    
    // MARK: Create Url for API call
    func createUrl(forMethod: APIcallsForUser) -> URL {
        switch forMethod {
        case .signUp, .profileUpdate, .getUser:
            return URL(string: Constants.Url.signUpUrl)!
        case .login:
            return URL(string: Constants.Url.loginUrl)!
        case .logout:
            return URL(string: Constants.Url.signOutUrl)!
        case .checkEmail:
            return  URL(string: Constants.Url.checkEmail+"?email=\(email)")!
        case .phoneVerify:
            return URL(string: Constants.Url.phoneVerify)!
        case .otpVerify:
            return URL(string: Constants.Url.sendOTP)!
        case .changePassword:
            return URL(string: Constants.Url.updatePassword)!
        case .getUserById:
            return URL(string: Constants.Url.signUpUrl+"/\(userId)")!
        }
    }
    
    // MARK: - Create Request for API call
    func createRequest(forMethod: APIcallsForUser) -> URLRequest {
        var request: URLRequest
        switch forMethod{
        case .signUp, .profileUpdate:
            request = URLRequest(url: createUrl(forMethod: .signUp))
            request.httpMethod = isUpdating ? Constants.Methods.put : Constants.Methods.post
            let jsonData = try? JSONSerialization.data(withJSONObject: isUpdating ?  getData(method: CreateJsonForUserAPI.profileUpdate)! : getData(method: CreateJsonForUserAPI.signUp)!, options: [])
            request.httpBody = jsonData
            request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
            return request
            
        case .login:
            request = URLRequest(url: createUrl(forMethod: .login))
            request.httpMethod = Constants.Methods.post
            let jsonData = try? JSONSerialization.data(withJSONObject: getData(method: CreateJsonForUserAPI.login)!, options: [])
            request.httpBody = jsonData
            request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
            return request
            
        case .logout:
            request = URLRequest(url: createUrl(forMethod: .logout))
            request.httpMethod = Constants.Methods.delete
            return request
            
        case .getUser:
            request = URLRequest(url: createUrl(forMethod: .getUser))
            request.httpMethod = Constants.Methods.get
            return request
        case .checkEmail:
            request = URLRequest(url: createUrl(forMethod: .checkEmail))
            request.httpMethod = Constants.Methods.get
            return request
            
        case .phoneVerify, .otpVerify:
            request = URLRequest(url: createUrl(forMethod: sendOTP ? .otpVerify : .phoneVerify))
            request.httpMethod = Constants.Methods.post
            let jsonData = try? JSONSerialization.data(withJSONObject: getData(method: sendOTP ? .otpVerify : .phoneVerify )!, options: [])
            request.httpBody = jsonData
            request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
            return request
            
        case .changePassword:
            request = URLRequest(url: createUrl(forMethod: .changePassword))
            request.httpMethod = Constants.Methods.patch
            let jsonData = try? JSONSerialization.data(withJSONObject: getData(method: .changePassword)!, options: [])
            request.httpBody = jsonData
            request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
            return request
        case .getUserById:
            request = URLRequest(url: createUrl(forMethod: .getUserById))
            request.httpMethod = Constants.Methods.get
            return request
        }
    }
    
    // MARK: - Make API call
    func apiCall(forMethod: APIcallsForUser) {
        isLoading = true
        switch forMethod {
        case .login:
            ApiManager.shared.apiAuthMethod(method: .login,request: createRequest(forMethod: .login))
        case .signUp,.profileUpdate:
            ApiManager.shared.apiAuthMethod(method: isUpdating ? .profileUpdate : .signUp,request: createRequest(forMethod: .signUp))
        case .checkEmail:
            ApiManager.shared.apiAuthMethod(method: .checkEmail, request: createRequest(forMethod: .checkEmail))
        case .logout:
            ApiManager.shared.apiAuthMethod(method: .logout, request: createRequest(forMethod: .logout))
        case .getUser:
            ApiManager.shared.apiAuthMethod(method: .getUser, request: createRequest(forMethod: .getUser))
        case .phoneVerify:
            ApiManager.shared.apiAuthMethod(method: .phoneVerify, request: createRequest(forMethod: .phoneVerify))
        case .otpVerify:
            ApiManager.shared.apiAuthMethod(method: .otpVerify, request: createRequest(forMethod: .otpVerify))
        case .changePassword:
            ApiManager.shared.apiAuthMethod(method: .changePassword, request: createRequest(forMethod: .changePassword))
        case .getUserById:
            ApiManager.shared.apiAuthMethod(method: .getUserById, request: createRequest(forMethod: .getUserById))
        }
    }
  
        // MARK: - Create Json for API call
    func getData(method: CreateJsonForUserAPI) -> [String: Any]? {
        switch method {
        case .signUp:
            return [Constants.JsonKey.user:
                            [
                                Constants.Url.email: email,
                                Constants.Url.password: password,
                                Constants.Url.fname: fname,
                                Constants.Url.lname: lname,
                                Constants.Url.dob: bday,
                                Constants.Url.title: selectedTitle
                            ]
                    ]

        case .profileUpdate:
            return  [Constants.JsonKey.user:
                        [
                            Constants.Url.fname: fname,
                            Constants.Url.lname: lname,
                            Constants.Url.dob: bday,
                            Constants.Url.title: selectedTitle,
                            Constants.Url.bio: bio,
                            Constants.Url.travelPreference: travelPreference,
                            Constants.Url.postalAddress: postalAddress
                        ]]
                  

        case .login:
            return [Constants.JsonKey.user:
                [
                    Constants.Url.email: email,
                    Constants.Url.password: password
                ]
            ]
            

        case .phoneVerify:
           return [
                            Constants.Url.phnnumber: phoneNumber
           ]

        case .otpVerify:
            return [
                Constants.Url.phnnumber: phoneNumber,
                Constants.Url.passcode: passcode
            ]
            
            
        case .changePassword:
            return [
                Constants.Url.currentPassword: oldPassword,
                Constants.Url.password: newPassword,
                Constants.Url.confirmPassword: confirmNewPassword
            ]
        }
    }

    
    
    // MARK: Phone Verify
//    func phoneVerify() {
//        var phoneurl: URL?
//        if sendOTP {
//            phoneurl = URL(string: Constants.Url.sendOTP)
//        } else {
//           phoneurl = URL(string: Constants.Url.phoneVerify)
//        }
//
//        guard let url = phoneurl else {
//            print(Constants.Error.invalidUrl)
//            return
//        }
//        self.isLoading = true
//        var userData: [String: Any]?
//        if !sendOTP {
//             userData = [
//                Constants.Url.phnnumber: phoneNumber,
//                Constants.Url.passcode: passcode
//            ]
//        } else {
//             userData = [
//                Constants.Url.phnnumber: phoneNumber
//            ]
//        }
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: userData as Any, options: [])
//
//        var request = URLRequest(url: url)
//        request.httpMethod = Constants.Methods.post
//        request.httpBody = jsonData
//        request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
//
//
//        if let token = UserDefaults.standard.object(forKey: Constants.Url.token) as? String {
//            request.setValue(token, forHTTPHeaderField: Constants.Url.auth)
//        } else {
//            // Key not found or value not a String
//        }
//        URLSession.shared.dataTaskPublisher(for: request)
//            .tryMap { data, response -> Data in
//                guard let httpResponse = response as? HTTPURLResponse else {
//                    throw URLError(.badServerResponse)
//                }
//
//
//                if (200...299).contains(httpResponse.statusCode) {
//                    print(httpResponse.statusCode)
//                    self.verified = true
//                } else {
//                    print(httpResponse.statusCode)
//                        self.failtToSendOtpAlert.toggle()
//                }
//                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                    print(json)
//                }
//
//                return data
//            }
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                self.isLoading = false
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print("Error: \(error.localizedDescription)")
//                }
//            }, receiveValue: { decodedData in
//                print(decodedData)
//            })
//            .store(in: &publishers)
//
//    }
}
