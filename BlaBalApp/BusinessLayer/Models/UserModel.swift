// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)



import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let status: Status
}

// MARK: - Status
struct Status: Codable {
    let code: Int
    let error: String?
    let message: String?
    let data: DataClass?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case code, data, error, message
        case imageURL = "image_url"
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let id: Int
    let email, createdAt, updatedAt, jti: String
    let firstName, lastName, dob, title: String
    let phoneNumber, bio, travelPreferences, postalAddress: String?
    let activationDigest: String
    let activated: Bool?
//    let activatedAt: JSONNull?
    let activateToken: String
    let sessionKey: String?
    let averageRating: Double?
    let otp: Int
    let phoneVerified: Bool?

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
//        case activatedAt = "activated_at"
        case activateToken = "activate_token"
        case sessionKey = "session_key"
        case averageRating = "average_rating"
        case otp
        case phoneVerified = "phone_verified"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
