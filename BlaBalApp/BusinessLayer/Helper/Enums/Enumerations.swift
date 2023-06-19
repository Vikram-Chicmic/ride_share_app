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

enum HttpMethod: String {
    case POST
    case GET
    case PUT
    case DELETE
}


enum ApiMethods: String {
    case signIn = "POST"
    case signUp = "POST "
    case signOut = "DELETE"
    case emailCheck = "GET"
    case profileUpdate = "PUT"
}

enum ApiVehicleMethods: String{
    case addVehicle = "POST"
    case vehicleList = "GET"
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
