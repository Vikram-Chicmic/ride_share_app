//
//  ChatViewModel.swift
//  BlaBalApp
//
//  Created by ChicMic on 12/07/23.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var receiverId: Int?
    @Published var publishId: Int?
    @Published var chatId: Int?
    @Published var message: String?
    @Published var chatRoomSuccessAlert = false
    @Published var chatRoomFailAlert = false
    @Published var notFoundErrorAlert = false
    @Published var allChats: [Chat]?
    @Published var allMessages: [Message]?
    @Published var roomCreateRespone: ChatData?
    static var shared = ChatViewModel()
    
    private var publishers = Set<AnyCancellable>()
    
    func apiCall(mehtod: APIcallsForChat) {
        switch mehtod {
        case .createChatRoom:
            ApiManager.shared.apiCallForChat(method: .createChatRoom, request: createRequest(method: .createChatRoom))
        case .getAllChatRoom:
            ApiManager.shared.apiCallForChat(method: .getAllChatRoom, request: createRequest(method: .getAllChatRoom))
        case .sendMessage:
            ApiManager.shared.apiCallForChat(method: .sendMessage, request: createRequest(method: .sendMessage))
        case .recieveMessage:
            ApiManager.shared.apiCallForChat(method: .recieveMessage, request: createRequest(method: .recieveMessage))
        }
    }
    
    func createJSON(method: APIcallsForChat) -> [String: Any] {
        switch method {
        case .createChatRoom:
            return  [ "chat": [
                "receiver_id": receiverId,
                "publish_id": publishId
            ]
            ]
            
        case .getAllChatRoom, .recieveMessage:
            return [:]
            
        case .sendMessage:
            return [ "message": [
                "content": message,
                "receiver_id": receiverId
            ]
            ]
        }
    }
    
    func createURL(method: APIcallsForChat) -> URL {
        switch method {
        case .createChatRoom, .getAllChatRoom:
            return URL(string: Constants.Url.createChat)!
        case .sendMessage, .recieveMessage:
            return URL(string: Constants.Url.createChat+"/\(chatId!)/messages")!
        }
    }
    
    func createRequest(method: APIcallsForChat) -> URLRequest {
        switch method {
        case .createChatRoom:
            var request = URLRequest(url: createURL(method: .createChatRoom))
            request.httpMethod = Constants.Methods.post
            let jsonData   = try? JSONSerialization.data(withJSONObject: createJSON(method: .createChatRoom), options: [])
            request.httpBody = jsonData
            request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
            return request
            
        case .getAllChatRoom:
            var request = URLRequest(url: createURL(method: .getAllChatRoom))
            request.httpMethod = Constants.Methods.get
            return request
            
        case .sendMessage:
            var request = URLRequest(url: createURL(method: .sendMessage))
            request.httpMethod = Constants.Methods.post
            let jsonData   = try? JSONSerialization.data(withJSONObject: createJSON(method: .sendMessage), options: [])
            request.httpBody = jsonData
            request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
            return request
            
        case .recieveMessage:
            var request = URLRequest(url: createURL(method: .recieveMessage))
            request.httpMethod = Constants.Methods.get
            return request
        }
    }
}
