//
//  GoogleLatLongModel.swift
//  BlaBalApp
//
//  Created by ChicMic on 02/06/23.
//

import Foundation


// MARK: - PlacesResponse
struct PlacesResponse: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let name: String
    let formattedAddress: String
    let geometry: Geometry

    enum CodingKeys: String, CodingKey {
        case formattedAddress = "formatted_address"
        case geometry
        case name
    }
}

// MARK: - Geometry
struct Geometry: Codable {
    let location: Location
}

// MARK: - Location
struct Location: Codable {
    let lat, lng: Double
}
