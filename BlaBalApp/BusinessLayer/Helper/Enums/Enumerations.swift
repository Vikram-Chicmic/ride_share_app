//
//  FormViewEnum.swift
//  BlaBalApp
//
//  Created by ChicMic on 14/06/23.
//

import Foundation

enum ProfileViewEnum {
    case nameView, dOBView, titleView
}

enum Title: String, CaseIterable {
     case mr = "Mr."
     case miss = "Miss."
     case mrs = "Mrs."
 }

enum DecodeType {
    case signIn, signUp, getUser
}

enum CreateJsonForUserAPI {
    case signUp
    case login
    case profileUpdate
    case phoneVerify
    case otpVerify
    case changePassword
}

enum APIcallsForUser {
    case signUp
    case login
    case logout
    case getUser
    case checkEmail
    case profileUpdate
    case phoneVerify
    case otpVerify
    case changePassword
}

enum APIcallsForVehicle {
    case vehicleRegister
    case vehicleUpdate
    case getVehicle
    case deleteVehicle
}

enum APIcallsForRides {
    case publishRide
    case bookRide
    case searchRide
    case fetchPlaces
    case publishRideDetail
}





enum AuthenticateError: LocalizedError{
    case badURL
    case badResponse
    case url(URLError?)
    case unknown
    case badConversion
    case noData
    case parsing(DecodingError?)
    case userExists
    case noUserExists
    
    // MARK: custom error description for errors
    var errorDescription: String?{
        switch self{
        case .badConversion:
            return "Cannot convert to json data"
        case .badURL:
            return "URL not found"
        case .badResponse:
            return "Something went wrong, Please check"
        case .url(let error):
            return "\(error?.localizedDescription ?? "")"
        case .unknown:
            return "Sorry, something went wrong."
        case .noData:
            return "No data found"
        case .parsing(let error):
            return "Parsing Error \n\(error?.localizedDescription ?? "")"
        case .userExists:
            return "User Already Exists,\n Log In to continue"
        case .noUserExists:
            return "No Such User Exists,\n Sign Up to continue"
        }
    }
}
