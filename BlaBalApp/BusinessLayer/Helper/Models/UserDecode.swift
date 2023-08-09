// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let decodeUser = try? JSONDecoder().decode(DecodeUser.self, from: jsonData)

import Foundation

// MARK: - DecodeUser
struct DecodeUser: Codable {
    let code: Int
    let user: DecodeUserData
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case code, user
        case imageURL = "image_url"
    }
}

// MARK: - User
struct DecodeUserData: Codable {
    let id: Int
    let email, createdAt, updatedAt, jti: String
    let firstName, lastName, dob, title: String
    let phoneNumber: String?
    let bio: String
    let travelPreferences, postalAddress: JSONNull4?
    let activationDigest: String
    let activated: Bool
    let activatedAt: JSONNull4?
    let activateToken: String
    let sessionKey, averageRating: JSONNull4?
    let otp: Int
    let phoneVerified: Bool

    enum CodingKeys: String, CodingKey {
        case id, email
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case jti
        case firstName = "first_name"
        case lastName = "last_name"
        case dob, title
        case phoneNumber = "phone_number"
        case bio
        case travelPreferences = "travel_preferences"
        case postalAddress = "postal_address"
        case activationDigest = "activation_digest"
        case activated
        case activatedAt = "activated_at"
        case activateToken = "activate_token"
        case sessionKey = "session_key"
        case averageRating = "average_rating"
        case otp
        case phoneVerified = "phone_verified"
    }
}

// MARK: - Encode/decode helpers

class JSONNull4: Codable, Hashable {

    public static func == (lhs: JSONNull4, rhs: JSONNull4) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull4.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
