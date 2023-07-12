//
//  LocationManager.swift
//  BlaBalApp
//
//  Created by ChicMic on 27/06/23.
//
//

import Foundation
import CoreLocation
import MapKit

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var currentLocation: String = ""
    
     let locationManager: CLLocationManager
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
      
       
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    /// function to request for permission
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    ///  function to start the updation of location
    func startLocationUpdation() {
        locationManager.startUpdatingLocation()
    }
    
    ///  method which is invoked and assign new value when authorization status is changed
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    /// method to stop the updation of location
    func stopLocationUpdation() {
        locationManager.stopUpdatingLocation()
    }
    
    ///  mehod to fetch all locations in form of cllocation array and pass the first value of array to fetchCountryandcity method
    /// - Parameters:
    ///   - manager: manager is clllocation manager
    ///   - locations: locaitons is array of all locaiton in clllocation fomat
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        fetchCountryAndCity(for: locations.first)
    }
    
    ///  method to fetch country and city based on given cllocation cordinated
    /// - Parameter location: loaction is cllocation type variable which hold cordinates
    func fetchCountryAndCity(for location: CLLocation?) {
        guard let location = location else {
            return
        }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, _) in
            self.currentLocation = "\(placemarks?.first?.administrativeArea ?? "") \(placemarks?.first?.country ?? "")"
            MapAndSearchRideViewModel.shared.searchText = self.currentLocation
        }
    }
}
