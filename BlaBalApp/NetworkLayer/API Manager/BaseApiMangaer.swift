//
//  BaseApiMangaer.swift
//  BlaBalApp
//
//  Created by ChicMic on 21/06/23.
//

import Foundation

class BaseApiManager: ObservableObject {
    static var shared = BaseApiManager()
    @Published var successAlert = false
    @Published var errorAlert = false
    
    // MARK: Case Handling for User API calls
    ///success case
    func successCaseHandler(method: APIcallsForUser, data: Data, response: HTTPURLResponse) {
        switch method {
        case .login:
            UserDefaults.standard.set(true, forKey: Constants.Url.userLoggedIN)
            LoginSignUpViewModel.shared.navigate.toggle()
            print(  LoginSignUpViewModel.shared.navigate)

        case .signUp:
            LoginSignUpViewModel.shared.alert.toggle()
            
        case .logout:
            UserDefaults.standard.set(false, forKey: Constants.UserDefaultsKeys.userLoggedIn)
            UserDefaults.standard.removeObject(forKey: Constants.Url.token)
            
        case .getUser:
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(Welcome.self, from: data)
                LoginSignUpViewModel.shared.recievedData = user
                print(user)
            } catch {
                print("Cant decode recieved Data.")
            }

        case .checkEmail:
            LoginSignUpViewModel.shared.navigateToForm.toggle()
            
        case .profileUpdate:
            LoginSignUpViewModel.shared.successUpdate.toggle()
            
            
        case .phoneVerify, .otpVerify:
            LoginSignUpViewModel.shared.verified = true
        
          
        case .changePassword:
            LoginSignUpViewModel.shared.passwordChangeAlert.toggle()
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
    
  ///failure cases
    func failureCaseHandler(method: APIcallsForUser, data: Data, response: HTTPURLResponse) {
        switch method {
        case .login:
            print("Failed while login.")
            LoginSignUpViewModel.shared.showAlert.toggle()
        case .signUp:
            print("Failed while signUp.")
            LoginSignUpViewModel.shared.showAlertSignUpProblem = true
        case .logout:
            print("Failed to logout")
        case .getUser:
            print("Failed to get user data.")
        case .checkEmail:
            print("Failed while checking email.")
            LoginSignUpViewModel.shared.showAlert.toggle()
        case .profileUpdate:
            print("Failed while update")
            LoginSignUpViewModel.shared.updateAlertProblem = true
        case .phoneVerify, .otpVerify:
            LoginSignUpViewModel.shared.failtToSendOtpAlert.toggle()
        case .changePassword:
            print("Fail to change password")
        }
    }
    
    // MARK: Case handling for vehicles api
    ///success case
    func successCaseHandleforVehicle(method: APIcallsForVehicle, data: Data, response: HTTPURLResponse) {
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
        
        case .getVehicleDetailsById:
            guard let vehicles = try? JSONDecoder().decode(Datum.self, from: data) else {
                return
            }
            RegisterVehicleViewModel.shared.specificVehicleDetails = vehicles
            print(vehicles)
        }
    }
    ///failure case
    func failureCaseHandleforVehicle(method: APIcallsForVehicle, data: Data, response: HTTPURLResponse) {
        switch method {
        case .vehicleRegister:
            print("Error while regestring")
        case .vehicleUpdate:
            print("Error while updating")
        case .getVehicle:
            print("Fail to fetch data")
        case .deleteVehicle:
            print("Error while deleting")
        case .getVehicleDetailsById:
            print("Error while fetching vehicle data")
        }
    }
    
    func successCaseHandleforRides(method: APIcallsForRides, data: Data, response: HTTPURLResponse) {
        switch method {
        case .publishRide:
            MapAndSearchRideViewModel.shared.alertSuccess.toggle()
        case .bookRide:
            MapAndSearchRideViewModel.shared.alertSuccess.toggle() //ride has been booked successfully
        case .searchRide:
            guard let result = try? JSONDecoder().decode(SearchRideResponse.self, from: data) else {
                print(Constants.Errors.decodeerror)
                return
            }
            MapAndSearchRideViewModel.shared.searchRideResult = result.data
        case .fetchPlaces:
            guard let result = try? JSONDecoder().decode(PlacesResponse.self, from: data) else {
                print(Constants.Errors.decodeerror)
                return
            }
            MapAndSearchRideViewModel.shared.searchResultArr = result
        case .fetchPolylineAndDistanceOfRide:
            guard let result = try? JSONDecoder().decode(DirectionsResponse.self, from: data) else {
                print("Cant decode the direction response")
               
                return
            }
            MapAndSearchRideViewModel.shared.estimatedTime = result.routes?[0].legs[0].duration.text ?? "can't estimate"
            MapAndSearchRideViewModel.shared.polylineString = result.routes?[0].overviewPolyline.points ?? ""
   
            
        case .getAllPublisghRideOfCurrentUser:
            guard let result = try? JSONDecoder().decode(AllPublishRide.self, from: data) else {
                print("Cant decode response for all rides published")
                return
            }
            MapAndSearchRideViewModel.shared.allPublishRides = result.data
            print(result.data)
        case .updateRide:
            MapAndSearchRideViewModel.shared.alertSuccess.toggle()
        case .cancelRide:
            print("Ride cancelled successfull")
        case .getAllBookedRideOfCurentUser:
            guard let result = try? JSONDecoder().decode(AllBookedRide.self, from: data) else {
                print("Cant decode response for all rides published")
                return
            }
            MapAndSearchRideViewModel.shared.allBookedRides = result
            print(result.rides)
        case .cancelBookedRide:
            print("Ride Cancelled Successfully")
        }
    }
    
    
    func failureCaseHandleForRide(method: APIcallsForRides, data:Data, response: HTTPURLResponse) {
        switch method {
        case .publishRide:
            print("Fail to publish ride")
        case .bookRide:
            print("Fail to book ride")
        case .searchRide:
            print("No data found")
        case .fetchPlaces:
            print("Failed to fetch places")
        case .fetchPolylineAndDistanceOfRide:
            print("unable to fetch data for directions")
        case .getAllPublisghRideOfCurrentUser:
            print("Unable to fetch your publish rides")
        case .updateRide:
            print("Cant update ride")
        case .cancelRide:
            print("Cant cancel ride")
        case .getAllBookedRideOfCurentUser:
            print("Cant get rides")
        case .cancelBookedRide:
            print("can't cancel ride")
        }
    }
    
    
}
