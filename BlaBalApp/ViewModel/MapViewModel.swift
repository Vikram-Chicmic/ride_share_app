//
//  MapViewModel.swift
//  BlaBalApp
//
//  Created by ChicMic on 25/05/23.
//

import Foundation
import MapKit
import CoreLocation
import Combine

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate, MKMapViewDelegate {
    @Published var searchText: String = ""
    var cancellable: AnyCancellable?
    @Published var mapView: MKMapView = .init()
    @Published var manager: CLLocationManager = .init()
    @Published var fetchedPlaces: [CLPlacemark]?
    override init() {
        super.init()
        manager.delegate = self
        mapView.delegate = self
        
        manager.requestWhenInUseAuthorization()
        
        cancellable = $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveValue: { value in
                if value != "" {
                    self.fetchPlaces(value: value)
                } else {
                    self.fetchedPlaces = nil
                }
                
            })
    }
    
    func fetchPlaces(value: String) {
        Task {
            do {
                let request = MKLocalSearch.Request()
                request.naturalLanguageQuery = value.lowercased()
                
                
                let response = try await MKLocalSearch(request: request).start()
                await MainActor.run(body: {
                    self.fetchedPlaces = response.mapItems.compactMap({ items -> CLPlacemark? in
                        return items.placemark
                    })
                })
            } catch {
                
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.last != nil else { return }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //
    }
    
        
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            switch manager.authorizationStatus {
                
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .restricted:
                print("Your location is restricted due to parental controls.")
            case .denied:
                print("Location is denied in app permission")
            case .authorizedAlways, .authorizedWhenInUse:
                manager.requestLocation()
            @unknown default:
                break
            }
        }
    
}
