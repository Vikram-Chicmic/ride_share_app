//
//  ForgotPasswordModel.swift
//  BlaBalApp
//
//  Created by ChicMic on 18/08/23.
//

import Foundation

struct ForgotPassword: Codable {
    let code: Int?
    let message: String?
    let error: String?
}
