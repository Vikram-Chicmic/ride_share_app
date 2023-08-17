//
//  GoogleLatLongModel.swift
//  BlaBalApp
//
//  Created by ChicMic on 02/06/23.
//

import Foundation


// MARK: - PlacesResponse
struct PlacesResponse: Codable {
    var results: [Result]
}

// MARK: - Result
struct Result: Codable {
    var name: String
    var formattedAddress: String
    var geometry: Geometry

    enum CodingKeys: String, CodingKey {
        case formattedAddress = "formatted_address"
        case geometry
        case name
    }
}

// MARK: - Geometry
struct Geometry: Codable {
    var location: Location
}

// MARK: - Location
struct Location: Codable {
    var lat, lng: Double
}
