//
//  RoomCreateResponseModel.swift
//  BlaBalApp
//
//  Created by ChicMic on 19/08/23.
//

import Foundation
struct ChatData: Codable {
    let code: Int
    let chat: SingleChat?
    let messages: [Message]?
    let error: String?
}

struct SingleChat: Codable {
    let id, senderID, receiverID, publishID: Int
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case receiverID = "receiver_id"
        case senderID = "sender_id"
        case publishID = "publish_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
