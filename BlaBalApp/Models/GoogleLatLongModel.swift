//
//  GoogleLatLongModel.swift
//  BlaBalApp
//
//  Created by ChicMic on 02/06/23.
//

import Foundation

// MARK: - Welcome
struct GoogleLatLongModel: Codable {
    let candidates: [Candidate]
    let status: String
}

// MARK: - Candidate
struct Candidate: Codable {
    let formattedAddress: String
    let geometry: Geometry

    enum CodingKeys: String, CodingKey {
        case formattedAddress = "formatted_address"
        case geometry
    }
}

// MARK: - Geometry
struct Geometry: Codable {
    let location: Location
    let viewport: Viewport
}

// MARK: - Location
struct Location: Codable {
    let lat, lng: Double
}

// MARK: - Viewport
struct Viewport: Codable {
    let northeast, southwest: Location
}
