//
//  AllPublishRideModel.swift
//  BlaBalApp
//
//  Created by ChicMic on 22/06/23.
//

import Foundation

// MARK: - AllPublishRide
struct AllPublishRide: Codable {
    let code: Int
    let data: [AllPublishRideData]
}

//// MARK: - Datum
//struct AllPublishRideData: Codable {
//    let id: Int
//    let source, destination: String
//    let passengersCount: Int
//    let addCity: JSONNull2?
//    let date, time: String
//    let setPrice: Int
//    let aboutRide: String
//    let userID: Int
//    let createdAt, updatedAt: String
//    let sourceLatitude, sourceLongitude, destinationLatitude, destinationLongitude: Double
//    let vehicleID: Int
//    let bookInstantly, midSeat, selectRoute: JSONNull2?
//    let status, estimateTime: String
//    let addCityLongitude, addCityLatitude: JSONNull2?
//
//    enum CodingKeys: String, CodingKey {
//        case id, source, destination
//        case passengersCount = "passengers_count"
//        case addCity = "add_city"
//        case date, time
//        case setPrice = "set_price"
//        case aboutRide = "about_ride"
//        case userID = "user_id"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case sourceLatitude = "source_latitude"
//        case sourceLongitude = "source_longitude"
//        case destinationLatitude = "destination_latitude"
//        case destinationLongitude = "destination_longitude"
//        case vehicleID = "vehicle_id"
//        case bookInstantly = "book_instantly"
//        case midSeat = "mid_seat"
//        case selectRoute = "select_route"
//        case status
//        case estimateTime = "estimate_time"
//        case addCityLongitude = "add_city_longitude"
//        case addCityLatitude = "add_city_latitude"
//    }
//}
//
//// MARK: - Encode/decode helpers
//
//class JSONNull2: Codable, Hashable {
//
//    public static func == (lhs: JSONNull2, rhs: JSONNull2) -> Bool {
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
