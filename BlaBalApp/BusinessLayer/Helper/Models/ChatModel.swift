//
//  ChatMode.swift
//  BlaBalApp
//
//  Created by ChicMic on 13/07/23.
//


import Foundation

// MARK: - ChatDecode
struct ChatDecode: Codable {
    let code: Int
    let chats: [Chat]
}

// MARK: - Chat
struct Chat: Codable {
    let publish: AllPublishRideData
    let id, receiverID, senderID, publishID: Int
    let receiver, sender: Receiver
    let receiverImage: String?
    let senderImage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case receiverID = "receiver_id"
        case senderID = "sender_id"
        case publishID = "publish_id"
        case receiver, sender
        case receiverImage = "receiver_image"
        case senderImage = "sender_image"
        case publish
    }
}

// MARK: - Receiver
struct Receiver: Codable {
    let id: Int
    let email, createdAt, updatedAt, jti: String
    let firstName, lastName, dob, title: String
    let phoneNumber: String?
    let bio: String
    let travelPreferences, postalAddress: String?
    let activationDigest: String
    let activated: Bool
    let activatedAt: JSONNull?
    let activateToken: String
    let sessionKey: String?
    let averageRating: JSONNull?
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

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
