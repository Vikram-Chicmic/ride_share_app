//
//  UpdateUserModel.swift
//  BlaBalApp
//
//  Created by ChicMic on 23/05/23.
//

import Foundation


// MARK: - Welcome
struct UpdateUser: Codable {
    let user: UpdatedUser
}

// MARK: - User
struct UpdatedUser: Codable {
    let email, firstName, lastName, dob: String
    let title, phoneNumber, bio, travelPreferences: String
    let postalAddress: String

    enum CodingKeys: String, CodingKey {
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case dob, title
        case phoneNumber = "phone_number"
        case bio
        case travelPreferences = "travel_preferences"
        case postalAddress = "postal_address"
    }
}
