//
//  ChatReceiveModel.swift
//  BlaBalApp
//
//  Created by ChicMic on 13/07/23.
//

import Foundation

// MARK: - ChatDecode
struct ReceiveChat: Codable {
    let code: Int
    let messages: [Message]
}

// MARK: - Message
struct Message: Codable {
    let id: Int
    let content: String
    let senderID, receiverID: Int
    let createdAt, updatedAt: String
    let chatID: Int

    enum CodingKeys: String, CodingKey {
        case id, content
        case senderID = "sender_id"
        case receiverID = "receiver_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case chatID = "chat_id"
    }
}
