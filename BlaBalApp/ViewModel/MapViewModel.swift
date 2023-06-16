////
////  MapViewModel.swift
////  BlaBalApp
////
////  Created by ChicMic on 25/05/23.
////
//
//import Foundation
//import MapKit
//import CoreLocation
//import Combine
//
//class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate, MKMapViewDelegate {
//    @Published var searchText: String = ""
//    var cancellable: AnyCancellable?
//    @Published var mapView: MKMapView = .init()
//    @Published var manager: CLLocationManager = .init()
//    @Published var fetchedPlaces: [CLPlacemark]?
//    override init() {
//        super.init()
//        manager.delegate = self
//        mapView.delegate = self
//
//        manager.requestWhenInUseAuthorization()
//
//        cancellable = $searchText
//            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
//            .removeDuplicates()
//            .sink(receiveValue: { value in
//                if value != "" {
//                    self.fetchPlaces(value: value)
//                } else {
//                    self.fetchedPlaces = nil
//                }
//
//            })
//    }
//
//    func fetchPlaces(value: String) {
//        Task {
//            do {
//                let request = MKLocalSearch.Request()
//                request.naturalLanguageQuery = value.lowercased()
//
//
//                let response = try await MKLocalSearch(request: request).start()
//                await MainActor.run(body: {
//                    self.fetchedPlaces = response.mapItems.compactMap({ items -> CLPlacemark? in
//                        return items.placemark
//                    })
//                })
//            } catch {
//
//            }
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard locations.last != nil else { return }
//    }
//
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        //
//    }
//
//
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//            switch manager.authorizationStatus {
//
//            case .notDetermined:
//                manager.requestWhenInUseAuthorization()
//            case .restricted:
//                print("Your location is restricted due to parental controls.")
//            case .denied:
//                print("Location is denied in app permission")
//            case .authorizedAlways, .authorizedWhenInUse:
//                manager.requestLocation()
//            @unknown default:
//                break
//            }
//        }
//
//
//
//}
//
//
////    func getLatLong() {
////        guard !searchText.isEmpty else {
////            // Empty search text, reset the data or perform necessary actions
////            return
////        }
////
////        let url = URL(string: "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=formatted_address%2Cgeometry&input=\(searchText)&inputtype=textquery&key=AIzaSyDUzn63K64-sXadyIwRJExCfMaicagwGq4")!
////
////        // Cancel the previous search request
////        searchCancellable?.cancel()
////
////        // Delay the request by 0.5 seconds using debounce
////        searchCancellable = URLSession.shared.dataTaskPublisher(for: url)
////            .map(\.data)
////            .decode(type: GoogleLatLongModel.self, decoder: JSONDecoder())
////            .receive(on: DispatchQueue.main)
////            .sink(receiveCompletion: { completion in
////                switch completion {
////                case .finished:
////                    break
////                case .failure(let error):
////                    print("Error: \(error.localizedDescription)")
////                }
////            }, receiveValue: { data in
////                self.searchResultArr = data
////                print(data)
////            })
////
////        // Debounce the search text changes by 0.5 seconds
////        $searchText
////            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
////            .sink { [weak self] searchText in
////                self?.getLatLong()
////            }
////            .store(in: &publishers)
////    }
//
