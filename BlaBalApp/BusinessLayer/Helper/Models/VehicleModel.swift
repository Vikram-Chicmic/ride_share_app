//
//  VehicleModel.swift
//  BlaBalApp
//
//  Created by ChicMic on 24/05/23.
//

import Foundation


// MARK: - Welcome
//VehicleDataModel

// MARK: - Welcome
struct VehicleDataModel: Codable {
    let code: Int
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let country, vehicleNumber, vehicleBrand, vehicleName: String
    let vehicleType, vehicleColor: String
    let vehicleModelYear, userID: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, country
        case vehicleNumber = "vehicle_number"
        case vehicleBrand = "vehicle_brand"
        case vehicleName = "vehicle_name"
        case vehicleType = "vehicle_type"
        case vehicleColor = "vehicle_color"
        case vehicleModelYear = "vehicle_model_year"
        case userID = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
