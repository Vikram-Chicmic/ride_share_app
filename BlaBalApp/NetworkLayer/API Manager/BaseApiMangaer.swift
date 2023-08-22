//
//  BaseApiMangaer.swift
//  BlaBalApp
//
//  Created by ChicMic on 21/06/23.
//

import Foundation
import UIKit
import SwiftUI

class BaseApiManager: ObservableObject {
    static var shared = BaseApiManager()
  
    
 
    
    // MARK: Case Handling for User API calls
    /// success case
    /// - Parameters:
    ///   - method: method to handle success case for vehicleAPI's
    ///   - data: taking three input as method it use , data provided by api response and httpUrlresponse for status check
    ///   - response: return alert and navigation instructions
    func successCaseHandler(method: APIcallsForUser, data: Data, response: HTTPURLResponse) {
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            print(json as Any)
        } catch let e {
            print(e.localizedDescription)
        }
        switch method {
        case .login:
            UserDefaults.standard.set(true, forKey: Constants.Url.userLoggedIN)
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(Welcome.self, from: data)
                LoginSignUpViewModel.shared.recievedData = user
                print(user)
                
            } catch {
                print("\(error.localizedDescription)")
            }
            UserDefaults.standard.set(data, forKey: Constants.UserDefaultsKeys.userDataKey)
            LoginSignUpViewModel.shared.navigate.toggle()

        case .signUp:
            LoginSignUpViewModel.shared.fname = ""
            LoginSignUpViewModel.shared.lname = ""
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(Welcome.self, from: data)
                LoginSignUpViewModel.shared.recievedData = user
                print(user)
                
            } catch {
                print("\(error.localizedDescription)")
            }
            UserDefaults.standard.set(data, forKey: Constants.UserDefaultsKeys.userDataKey)
            LoginSignUpViewModel.shared.alert.toggle()
            LoginSignUpViewModel.shared.navigateToTabView.toggle()
     
            
        case .logout:
            UserDefaults.standard.set(false, forKey: Constants.UserDefaultsKeys.userLoggedIn)
            UserDefaults.standard.removeObject(forKey: Constants.Url.token)
            UserDefaults.standard.set(nil, forKey: Constants.UserDefaultsKeys.userDataKey)
            LoginSignUpViewModel.shared.currentState = .searchView
            NavigationViewModel.shared.pop()
            
        case .getUser:
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(Welcome.self, from: data)
                LoginSignUpViewModel.shared.recievedData = user
                print(user)
                
            } catch {
                print("\(error.localizedDescription)")
            }

        case .checkEmail:
            LoginSignUpViewModel.shared.navigateToForm.toggle()
            
        case .profileUpdate:
            LoginSignUpViewModel.shared.successUpdate.toggle()
            
            
        case .phoneVerify:
            LoginSignUpViewModel.shared.otpSended = true
        
        case .otpVerify:
            LoginSignUpViewModel.shared.phoneOTPVerified = true
          
        case .changePassword:
            LoginSignUpViewModel.shared.passwordChangeSuccessAlert.toggle()
            
        case .getUserById:
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(DecodeUser.self, from: data)
                LoginSignUpViewModel.shared.decodedData = user
                print(user)
            } catch {
                print("\(error.localizedDescription)")
            }
         
        case .forgotPassword:
            withAnimation {
                LoginSignUpViewModel.shared.alertOtpSendSucces = true
            }
        case .verifyEmailOtp:
            LoginSignUpViewModel.shared.emailOtpVerified.toggle()
            print("OTP verified navigate to new password")
        case .resetPassword:
            LoginSignUpViewModel.shared.resetPasswordSuccess.toggle()
            print("password has been resetted")
        }
        
        // MARK: Assigning and Clearing data of userdefaults
        if method.self == .logout {
            UserDefaults.standard.set("", forKey: Constants.Url.token)
        } else if method.self == .signUp || method.self == .login {
            UserDefaults.standard.set( true, forKey: Constants.Url.userLoggedIN)
            let bearer = response.value(forHTTPHeaderField: Constants.Url.auth)
            if let bearer {
                UserDefaults.standard.set(bearer, forKey: Constants.Url.token)
                LoginSignUpViewModel.authorizationToken = bearer
            }
        }
        
    }
    
    /// failure case
    /// - Parameters:
    ///   - method: method to handle failure case for userAPI's
    ///   - data:  taking three input as method it use , data provided by api response and httpUrlresponse for status check
    ///   - response: return alert and error description
    func failureCaseHandler(method: APIcallsForUser, data: Data, response: HTTPURLResponse) {
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            print(json)
        } catch let e {
            print(e.localizedDescription)
        }
        switch method {
        case .login:
            print(ErrorAlert.login.rawValue)
            LoginSignUpViewModel.shared.showAlert.toggle()
        case .signUp:
            print(ErrorAlert.signup.rawValue)
            LoginSignUpViewModel.shared.showAlertSignUpProblem = true
        case .logout:
            LoginSignUpViewModel.shared.failToLogout.toggle()
            print(ErrorAlert.logout.rawValue)
        case .getUser:
            LoginSignUpViewModel.shared.failToFetchUser.toggle()
            print(ErrorAlert.getUser.rawValue)
        case .checkEmail:
            LoginSignUpViewModel.shared.showAlert.toggle()
        case .profileUpdate:
            print(ErrorAlert.profileUpdate.rawValue)
            LoginSignUpViewModel.shared.updateAlertProblem = true
        case .phoneVerify, .otpVerify:
            print(ErrorAlert.phoneVerified.rawValue)
            LoginSignUpViewModel.shared.failtToSendOtpAlert.toggle()
        case .changePassword:
            LoginSignUpViewModel.shared.passwordChangeFailAlert.toggle()
            print(ErrorAlert.changePassword.rawValue)
        case .getUserById:
            print(ErrorAlert.getUser.rawValue)
        case .forgotPassword:
            LoginSignUpViewModel.shared.failtToSendOtpAlertForEmail.toggle()
            print("Fail to send otp")
        case .verifyEmailOtp:
            LoginSignUpViewModel.shared.failtToSendOtpAlertForEmail = true
            print("invalid otp")
        case .resetPassword:
            LoginSignUpViewModel.shared.resetPasswordFail.toggle()
            print("Fail to reset password")
        }
    }
    
    // MARK: Case handling for vehicles api
    /// success case
    /// - Parameters:
    ///   - method: method to handle success case for vehicleAPI's
    ///   - data: taking three input as method it use , data provided by api response and httpUrlresponse for status check
    ///   - response: return alert and navigation instructions
    func successCaseHandleforVehicle(method: APIcallsForVehicle, data: Data, response: HTTPURLResponse) {
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            print(json)
        } catch let e {
            print(e.localizedDescription)
        }
        switch method {
        case .vehicleRegister, .vehicleUpdate:
            RegisterVehicleViewModel.shared.successAlert.toggle()
        case .getVehicle:
            guard let vehicles = try? JSONDecoder().decode(VehicleDataModel.self, from: data) else {
                return
            }
            
            RegisterVehicleViewModel.shared.decodedVehicleData = vehicles
        case .deleteVehicle:
            RegisterVehicleViewModel.shared.deleteSuccess.toggle()
            RegisterVehicleViewModel.shared.isDeletingVehicle = false
            RegisterVehicleViewModel.shared.apiCallForVehicles(method: .getVehicle)
        
        case .getVehicleDetailsById:
            guard let vehicles = try? JSONDecoder().decode(Datum.self, from: data) else {
                return
            }
            RegisterVehicleViewModel.shared.specificVehicleDetails = vehicles
            RegisterVehicleViewModel.shared.navigateToDetail.toggle()
//            print(vehicles)
        }
    }
    /// failure case
    /// - Parameters:
    ///   - method: method to handle failure case for vehicleAPI's
    ///   - data:  taking three input as method it use , data provided by api response and httpUrlresponse for status check
    ///   - response: return alert and error description
    func failureCaseHandleforVehicle(method: APIcallsForVehicle, data: Data, response: HTTPURLResponse) {
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            print(json)
        } catch let e {
            print(e.localizedDescription)
        }
        switch method {
        case .vehicleRegister:
            RegisterVehicleViewModel.shared.failAlert.toggle()
            print(ErrorAlert.registerVehicle.rawValue)
        case .vehicleUpdate:
            print(ErrorAlert.updateVehicle.rawValue)
        case .getVehicle:
            RegisterVehicleViewModel.shared.failAlert.toggle()
            print(ErrorAlert.getVehicle.rawValue)
        case .deleteVehicle:
            print(ErrorAlert.deleteVehicle.rawValue)
        case .getVehicleDetailsById:
            print(ErrorAlert.getVehicle.rawValue)
            RegisterVehicleViewModel.shared.navigateToDetail.toggle()
        }
    }
    
    
    
    /// success case
    /// - Parameters:
    ///   - method: method to handle success case for vehicleAPI's
    ///   - data: taking three input as method it use , data provided by api response and httpUrlresponse for status check
    ///   - response: return alert and navigation instructions
    func successCaseHandleforRides(method: APIcallsForRides, data: Data, response: HTTPURLResponse) {
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            print(json)
        } catch let e {
            print(e.localizedDescription)
        }
        
        LoginSignUpViewModel.shared.isLoading = false
        switch method {
        case .publishRide:
            MapAndRidesViewModel.shared.alertForPublish.toggle()
            MapAndRidesViewModel.shared.alertSuccess.toggle()
            print(SuccessAlerts.publishRide.rawValue)
        case .bookRide:
            MapAndRidesViewModel.shared.alertBookRideSuccess.toggle() //ride has been booked successfully
            print(SuccessAlerts.publishRide.rawValue)
        case .searchRide:
            guard let result = try? JSONDecoder().decode(SearchRideResponse.self, from: data) else {
                print(Constants.Errors.decodeerror)
                return
            }
            print(result)
            MapAndRidesViewModel.shared.searchRideResult = result.data
            
        case .fetchPlaces:
            guard let result = try? JSONDecoder().decode(PlacesResponse.self, from: data) else {
                print(Constants.Errors.decodeerror)
                return
            }
           
            MapAndRidesViewModel.shared.searchResultArr = result
            
        case .fetchPolylineAndDistanceOfRide:
            guard let result = try? JSONDecoder().decode(DirectionsResponse.self, from: data) else {
                print("Cant decode the direction response")
               
                return
            }
            
            if let result = result.routes {
                MapAndRidesViewModel.shared.estimatedTimeInSeconds = (result.first?.legs.first?.duration.value)
                MapAndRidesViewModel.shared.estimatedTime = result.first?.legs.first?.duration.text ?? ""
                MapAndRidesViewModel.shared.polylineString = result.first?.overviewPolyline.points ?? ""
            }
            print(result)

    
        case .getAllPublisghRideOfCurrentUser:
            guard let result = try? JSONDecoder().decode(AllPublishRide.self, from: data) else {
                print(ErrorAlert.decode.rawValue)
                return
            }
    
            MapAndRidesViewModel.shared.allPublishRides = result.data
          
            
        case .updateRide:
            MapAndRidesViewModel.shared.updateRideSuccess.toggle()
            MapAndRidesViewModel.shared.isUpdatedSuccess.toggle()
            
        case .cancelRide:
            MapAndRidesViewModel.shared.alertCancelRide.toggle()
            print(SuccessAlerts.cancelRide.rawValue)
            
        case .getAllBookedRideOfCurentUser:
            guard let result = try? JSONDecoder().decode(AllBookedRide.self, from: data) else {
                print(ErrorAlert.decode.rawValue)
                return
            }
            MapAndRidesViewModel.shared.allBookedRides = result
//            print(result.rides)
            
        case .cancelBookedRide:
            MapAndRidesViewModel.shared.alertSuccess.toggle()
            print(SuccessAlerts.cancelRide.rawValue)
        }
    }
    
    
    
    /// failure case
    /// - Parameters:
    ///   - method: method to handle failure case for vehicleAPI's
    ///   - data:  taking three input as method it use , data provided by api response and httpUrlresponse for status check
    ///   - response: return alert and error description
    func failureCaseHandleForRide(method: APIcallsForRides, data: Data, response: HTTPURLResponse) {
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            print(json!)
        } catch let e {
            print(e.localizedDescription)
        }
      
        switch method {
        case .publishRide:
            MapAndRidesViewModel.shared.alertForPublish.toggle()
            MapAndRidesViewModel.shared.alertFailure.toggle()
            print(ErrorAlert.publishRide.rawValue)
            
        case .bookRide:
            MapAndRidesViewModel.shared.alertBookRideFailure.toggle()
            print(ErrorAlert.bookRide.rawValue)
            
        case .searchRide:
            MapAndRidesViewModel.shared.alertFailure.toggle()
            print(ErrorAlert.searchRide.rawValue)
            
        case .fetchPlaces:
            MapAndRidesViewModel.shared.alertFailure.toggle()
            print(ErrorAlert.fetchPlaces.rawValue)
            
        case .fetchPolylineAndDistanceOfRide:
            MapAndRidesViewModel.shared.alertFailure.toggle()
            print(ErrorAlert.fetchPolylineAndDistance.rawValue)
            
        case .getAllPublisghRideOfCurrentUser:
            MapAndRidesViewModel.shared.alertFetchPublishedRideFailure.toggle()
            print(ErrorAlert.fetchPublishedRide.rawValue)
            
        case .updateRide:
            MapAndRidesViewModel.shared.alertFailure.toggle()
            print(ErrorAlert.updateRide.rawValue)
            
        case .cancelRide:
            MapAndRidesViewModel.shared.alertCancelRide.toggle()
            print(ErrorAlert.cancelRide.rawValue)
            
        case .getAllBookedRideOfCurentUser:
            MapAndRidesViewModel.shared.alertFetchBookedRideFailure.toggle()
            print(ErrorAlert.fetchBookedRide.rawValue)
            
        case .cancelBookedRide:
            MapAndRidesViewModel.shared.alertFailure.toggle()
            print(ErrorAlert.cancelRide.rawValue)
        }
    }
    
    /// success case
    /// - Parameters:
    ///   - method: method to handle success case for chat's
    ///   - data: taking three input as method it use , data provided by api response and httpUrlresponse for status check
    ///   - response: return alert and navigation instructions
    func successCaseHandlerForChat(method: APIcallsForChat, data: Data, response: HTTPURLResponse) {
        
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            print(json)
        } catch let e {
            print(e.localizedDescription)
        }
        
        switch method {
        case .createChatRoom:
            guard let result = try? JSONDecoder().decode(ChatData.self, from: data) else {
                print("Cant decode the chat response")
                return
            }
            ChatViewModel.shared.roomCreateRespone = result
            ChatViewModel.shared.chatId = result.chat?.id
            ChatViewModel.shared.receiverId = result.chat?.receiverID
            ChatViewModel.shared.chatRoomSuccessAlert.toggle()
            print("Room created successfully")
            
        case .getAllChatRoom:
            guard let result = try? JSONDecoder().decode(ChatDecode.self, from: data) else {
                return
            }
            ChatViewModel.shared.allChats = result.chats
            print("All chats get successfully")
        case .sendMessage:
            print("message send successfully")
        case .recieveMessage:
            guard let result = try? JSONDecoder().decode(ReceiveChat.self, from: data) else {
                return
            }
            ChatViewModel.shared.allMessages = result.messages
            print("message recieved successfully")
        }
    }
    
    /// failure case
    /// - Parameters:
    ///   - method: method to handle failure case for chat's
    ///   - data:  taking three input as method it use , data provided by api response and httpUrlresponse for status check
    ///   - response: return alert and error description
    func failureCaseHandlerForChat(method: APIcallsForChat, data: Data, response: HTTPURLResponse) {
        
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            print(json)
        } catch let e {
            print(e.localizedDescription)
        }
        
        switch method {
        case .createChatRoom:
           print(response.statusCode)
            guard let result = try? JSONDecoder().decode(ChatData.self, from: data) else {
                print("Cant decode the chat response")
                return
            }
            ChatViewModel.shared.roomCreateRespone = result
            if result.code == 404 {
                ChatViewModel.shared.notFoundErrorAlert.toggle()
                return
            }
            ChatViewModel.shared.chatId = result.chat?.id
            ChatViewModel.shared.receiverId = result.chat?.receiverID
            ChatViewModel.shared.chatRoomFailAlert.toggle()
            print("Failed to create chat room")
        case .getAllChatRoom:
            print("Failed to get all chats")
        case .sendMessage:
            print("Failed to send message")
        case .recieveMessage:
            print("Failed to recieve message")
        }
    }
    
    
}
