//
//  SendDataModel.swift
//  BlaBalApp
//
//  Created by ChicMic on 14/06/23.
//

import Foundation

// MARK: - SendDataDecode
struct SendDataDecode: Codable {
    let user: User
}

// MARK: - User
struct User: Codable {
    let email, password, firstName, lastName: String
    let dob, title: String
    let phoneNumber: Int

    enum CodingKeys: String, CodingKey {
        case email, password
        case firstName = "first_name"
        case lastName = "last_name"
        case dob, title
        case phoneNumber = "phone_number"
    }
}
