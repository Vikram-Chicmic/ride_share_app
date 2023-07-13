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
    case getUserById
    case changePassword
}

enum APIcallsForVehicle {
    case vehicleRegister
    case vehicleUpdate
    case getVehicle
    case deleteVehicle
    case getVehicleDetailsById
}

enum APIcallsForRides {
    case publishRide
    case bookRide
    case searchRide
    case fetchPlaces
    case fetchPolylineAndDistanceOfRide
    case getAllPublisghRideOfCurrentUser
    case getAllBookedRideOfCurentUser
    case updateRide
    case cancelRide
    case cancelBookedRide
}


enum APIcallsForChat {
    case createChatRoom
    case getAllChatRoom
    case sendMessage
    case recieveMessage
}

enum APIResponseCase {
    case success
    case failure
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
}
    enum SuccessAlerts: String {
        case login                  = "Logged in successfully"
        case signup                 = "Signed up successfully"
        case logout                 = "Logged out successfully"
        case profileUpdate          = "Profile Updated successfully"
        case phoneVerified          = "OTP has been sent"
        case otpVarification        = "OTP has been varified"
        case addVehicle             = "Vehicle added Successfully"
        case updateVehicle          = "Vehicle Updated Successfully"
        case deleteVehicle          = "Vehcile Deleted Successfully"
        case bookRide               = "Ride Booked Successfully"
        case cancelRide             = "Ride Cancelled Successfully"
        case updateRide             = "Ride Updated Successfully"
        case changePassword         = "Password Changed Successfully"
        case publishRide            = "Ride Published successfully"
    }
    
enum ErrorAlert: String {
    case decode                 = "Can't decode the data."
    case login                  = "Failed to Logged in"
    case signup                 = "Failed to Signed up"
    case logout                 = "Failed to Logged out"
    case profileUpdate          = "Failed to Update Profile"
    case phoneVerified          = "Failed to sent OTP"
    case getUser                = "Fail to get user data"
    case otpVarification        = "Failed to varify OTP"
    case addVehicle             = "Failed to add Vehicle"
    case updateVehicle          = "Failed to Updated Vehicle"
    case registerVehicle        = "Failed to register vehicle"
    case deleteVehicle          = "Failed to Deleted Vehicle"
    case bookRide               = "Failed to Book Ride"
    case cancelRide             = "Failed to Cancel Ride"
    case changePassword         = "Failed to Change Password"
    case updateRide             = "Fail to Update Ride"
    case searchRide             = "Failed to search Ride"
    case getVehicle             = "Fail to get vehicles"
    case publishRide            = "Failed to Publish ride"
    case fetchPublishedRide     = "Failed to fetch published rides"
    case fetchBookedRide        = "Failed to fetch booked rides"
    case fetchPlaces            = "Failed to fetch places"
    case fetchPolylineAndDistance = "Failed to fetch Polyline and Distance"
}
    
enum PickerType {
    case date
    case time
}
    
    
    
 
