// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let searchRideResponse = try? JSONDecoder().decode(SearchRideResponse.self, from: jsonData)

import Foundation

// MARK: - SearchRideResponse
struct SearchRideResponse: Codable {
    let code: Int
    let data: [SearchRideResponseData]
}

// MARK: - Datum
struct SearchRideResponseData: Codable {
    let id: Int
    let name, reachTime: String
    let imageURL, averageRating: JSONNull1?
    let aboutRide: String
    let publish: Publish

    enum CodingKeys: String, CodingKey {
        case id, name
        case reachTime = "reach_time"
        case imageURL = "image_url"
        case averageRating = "average_rating"
        case aboutRide = "about_ride"
        case publish
    }
}

// MARK: - Publish
struct Publish: Codable {
    let id: Int
    let source, destination: String
    let passengersCount: Int
    let addCity: JSONNull1?
    let date, time: String
    let setPrice: Int
    let aboutRide: String
    let userID: Int
    let createdAt, updatedAt: String
    let sourceLatitude, sourceLongitude, destinationLatitude, destinationLongitude: Double
    let vehicleID: Int
    let bookInstantly, midSeat: JSONNull1?
    let selectRoute: SelectRoute
    let status, estimateTime: String
    let addCityLongitude, addCityLatitude: JSONNull1?
    let distance: Double
    let bearing: String

    enum CodingKeys: String, CodingKey {
        case id, source, destination
        case passengersCount = "passengers_count"
        case addCity = "add_city"
        case date, time
        case setPrice = "set_price"
        case aboutRide = "about_ride"
        case userID = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case sourceLatitude = "source_latitude"
        case sourceLongitude = "source_longitude"
        case destinationLatitude = "destination_latitude"
        case destinationLongitude = "destination_longitude"
        case vehicleID = "vehicle_id"
        case bookInstantly = "book_instantly"
        case midSeat = "mid_seat"
        case selectRoute = "select_route"
        case status
        case estimateTime = "estimate_time"
        case addCityLongitude = "add_city_longitude"
        case addCityLatitude = "add_city_latitude"
        case distance, bearing
    }
}

// MARK: - SelectRoute
struct SelectRoute: Codable {
}

// MARK: - Encode/decode helpers

class JSONNull1: Codable, Hashable {

    public static func == (lhs: JSONNull1, rhs: JSONNull1) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull1.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
