//
//  ErrorResponse.swift
//  BlaBalApp
//
//  Created by ChicMic on 19/06/23.
//

import Foundation


struct ErrorResponse: Codable, Error {
    var status: ErrorStatus
}

struct ErrorStatus: Codable{
    var code: Int
    var message: String?
    var error: String?
}
