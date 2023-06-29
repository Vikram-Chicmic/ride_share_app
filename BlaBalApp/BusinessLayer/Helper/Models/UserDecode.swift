// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let decodeUser = try? JSONDecoder().decode(DecodeUser.self, from: jsonData)

import Foundation

// MARK: - DecodeUser
struct DecodeUser: Codable {
    let code: Int
    let user: DecodeUserData
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case code, user
        case imageURL = "image_url"
    }
}

// MARK: - User
struct DecodeUserData: Codable {
    let id: Int
    let email, createdAt, firstName, lastName: String
    let dob, title, phoneNumber, bio: String
    let travelPreferences, postalAddress: String
    let phoneVerified: Bool

    enum CodingKeys: String, CodingKey {
        case id, email
        case createdAt = "created_at"
        case firstName = "first_name"
        case lastName = "last_name"
        case dob, title
        case phoneNumber = "phone_number"
        case bio
        case travelPreferences = "travel_preferences"
        case postalAddress = "postal_address"
        case phoneVerified = "phone_verified"
    }
}
