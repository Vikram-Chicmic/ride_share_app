//
//  Logout.swift
//  BlaBalApp
//
//  Created by ChicMic on 15/06/23.
//

import Foundation

class SessionManager: ObservableObject {
    var isLoggedIn: Bool = false {
        didSet {
            rootId = UUID()
        }
    }
    
    @Published var rootId: UUID = UUID()
}
