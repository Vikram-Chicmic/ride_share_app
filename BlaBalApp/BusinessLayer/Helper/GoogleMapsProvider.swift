//
//  GoogleMapsProvider.swift
//  BlaBalApp
//
//  Created by ChicMic on 26/06/23.
//

import Foundation
import GoogleMaps

class GoogleMapsProvider {
    static func configure() {
        GMSServices.provideAPIKey(Constants.API.apiKey)
    }
}
