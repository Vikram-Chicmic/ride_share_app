//
//  MapAndSearchRideViewModel.swift
//  BlaBalApp
//
//  Created by ChicMic on 02/06/23.
//

import Combine
import Foundation

class MapAndSearchRideViewModel: ObservableObject {
    @Published var searchText = ""
    private var publishers = Set<AnyCancellable>()
    private var searchCancellable: AnyCancellable?
    @Published var searchResultArr: PlacesResponse?
    @Published var passengers = 1
    @Published var date       = ""
    @Published var time       = ""
    @Published var aboutRide = ""
    @Published var amount: String = "0"
    @Published var originData: Result?
    @Published var destinationData: Result?
    @Published var searchRideResult: [SearchRideResponseData]?
    @Published var vehicleId: Int = 0
    @Published var estimatedTime: String = ""
    @Published var estimatedDistance: String = ""
    @Published var alertSuccess = false
    @Published var alertSuccessRide = false
    @Published var publishId = 0
    @Published var noOfSeatsToBook = 0
    @Published var polylineString: String = ""
    private let apiKey = Constants.API.apiKey
    @Published var allPublishRides: [AllPublishRideData]?
    
    static var shared = MapAndSearchRideViewModel()
    
    private func createURL(for query: String) -> String {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = Constants.Url.mapUrl+"\(encodedQuery)&key=\(apiKey)"
        return urlString
    }
    
    func createUrl(method: APIcallsForRides) -> URL {
        switch method {
        case .publishRide, .getAllRidePublisghRideOfCurrentUser:
            return URL(string: Constants.Url.publishRide)!
        case .bookRide:
            return URL(string: Constants.Url.bookRide)!
        case .searchRide:
            return URL(string: generateURL())!
        case .fetchPlaces:
            return URL(string: createURL(for: searchText))!
        case .fetchPolylineAndDistanceOfRide:
            return URL(string: generateUrlForFetchPublishRideDetails())!
        case .updateRide:
            return URL(string: Constants.Url.publishRide+"/\(RegisterVehicleViewModel.shared.updatingRidePublishId)")!
        case .cancelRide:
            return URL(string: Constants.Url.cancelRide)!
        }
    }
    
    
    func generateUrlForFetchPublishRideDetails() -> String {
        let url: String
        if let originData1 = originData?.geometry.location, let destinationData1 = destinationData?.geometry.location {
             url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(originData1.lat),\(originData1.lng)&destination=\(destinationData1.lat),\(destinationData1.lng)&key=\(Constants.API.apiKey)"
            return url
        }
        return ""
    }
    
    
    func generateJSONfor(mehod: APIcallsForRides) -> [String: Any]{
        switch mehod {
        case .publishRide, .updateRide:
            return [Constants.JsonKey.publish: [
                Constants.Url.source: originData?.name,
                Constants.Url.destination: destinationData?.name,
                Constants.Url.sourceLong: originData?.geometry.location.lng,
                Constants.Url.sourceLat: originData?.geometry.location.lat,
                Constants.Url.destLong: destinationData?.geometry.location.lng,
                Constants.Url.destLat: destinationData?.geometry.location.lat,
                Constants.Url.passengerCount: Int(passengers),
                Constants.Url.date: date,
                Constants.Url.time: time,
                Constants.Url.setPrice: Double(amount),
                Constants.Url.vehicleId: vehicleId,
                Constants.Url.aboutRide: aboutRide,
                Constants.Url.estimateTime: estimatedTime
            ] ]
        case .bookRide:
            return  [Constants.JsonKey.passenger: [
                Constants.Url.publishId: publishId,
                Constants.Url.seats: noOfSeatsToBook
            ]]
        case .searchRide, .fetchPlaces:
            return [:]
       
        case .fetchPolylineAndDistanceOfRide:
            return [:]
        case .getAllRidePublisghRideOfCurrentUser:
            return [:]
        case .cancelRide:
            return ["id": publishId]
        }
    }
    
    
    
    
    
    

    
    
    func createRequest(method: APIcallsForRides) -> URLRequest {
        var request: URLRequest
        switch method {
        case .publishRide:
            let jsonData = try? JSONSerialization.data(withJSONObject: generateJSONfor(mehod: .publishRide), options: [])
            request = URLRequest(url: createUrl(method: .publishRide))
            request.httpMethod = Constants.Methods.post
            request.httpBody = jsonData
            request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
            return request
            
        case .bookRide:
            let jsonData = try? JSONSerialization.data(withJSONObject: generateJSONfor(mehod: .bookRide), options: [])
            request = URLRequest(url: createUrl(method: .bookRide))
            request.httpMethod = Constants.Methods.post
            request.httpBody = jsonData
            request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
            return request
            
        case .searchRide:
            var request = URLRequest(url: createUrl(method: .searchRide))
            return request
      
        case .fetchPlaces:
            var request = URLRequest(url: createUrl(method: .fetchPlaces))
            return request
            
        case .fetchPolylineAndDistanceOfRide:
            var request = URLRequest(url: createUrl(method: .fetchPolylineAndDistanceOfRide))
            request.httpMethod = Constants.Methods.get
            return request
        case .getAllRidePublisghRideOfCurrentUser:
            var request = URLRequest(url: createUrl(method: .getAllRidePublisghRideOfCurrentUser))
            request.httpMethod = Constants.Methods.get
            return request
        case .updateRide:
            let jsonData = try? JSONSerialization.data(withJSONObject: generateJSONfor(mehod: .updateRide), options: [])
            var request = URLRequest(url: createUrl(method: .updateRide))
            request.httpMethod = Constants.Methods.put
            request.httpBody = jsonData
            request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
            return request
        case .cancelRide:
            let jsonData = try? JSONSerialization.data(withJSONObject: generateJSONfor(mehod: .cancelRide), options: [])
            var request = URLRequest(url: createUrl(method: .cancelRide))
            request.httpMethod = Constants.Methods.post
            request.httpBody = jsonData
            request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
            return request
        }
    }
    
    func apiCall(for method: APIcallsForRides) {
        switch method {
        case .publishRide:
            ApiManager.shared.apiCallForRides(method: .publishRide, request: createRequest(method: .publishRide))
        case .bookRide:
            ApiManager.shared.apiCallForRides(method: .bookRide, request: createRequest(method: .bookRide))
        case .searchRide:
            ApiManager.shared.apiCallForRides(method: .searchRide, request: createRequest(method: .searchRide))
        case .fetchPlaces:
            ApiManager.shared.apiCallForRides(method: .fetchPlaces, request: createRequest(method: .fetchPlaces))
        case .fetchPolylineAndDistanceOfRide:
            ApiManager.shared.apiCallForRides(method: .fetchPolylineAndDistanceOfRide, request: createRequest(method: .fetchPolylineAndDistanceOfRide))
        case .getAllRidePublisghRideOfCurrentUser:
            ApiManager.shared.apiCallForRides(method: .getAllRidePublisghRideOfCurrentUser, request: createRequest(method: .getAllRidePublisghRideOfCurrentUser))
        case .updateRide:
            ApiManager.shared.apiCallForRides(method: .updateRide, request: createRequest(method: .updateRide))
        case .cancelRide:
            ApiManager.shared.apiCallForRides(method: .cancelRide, request: createRequest(method: .cancelRide))
        }
    }
    
    func generateURL() -> String {
            var url = Constants.Url.searchRide
            if let og = originData?.geometry.location, let dt = destinationData?.geometry.location {
                
                url += Constants.Url.srcLong+"\(og.lng)"
                url += Constants.Url.srcLat+"\(og.lat)"
                url += Constants.Url.desLong+"\(dt.lng)"
                url += Constants.Url.desLat+"\(dt.lat)"
                url += Constants.Url.passCount+"\(passengers)"
                url += Constants.Url.dateUrl+"\(date)"
                print(url)
            }
            
            return url
        }
    

//    func bookRide(publishId: Int, seats: Int) {
//        guard let url = URL(string: Constants.Url.bookRide) else { return }
//
//        let publish = [
//            Constants.Url.publishId: publishId,
//            Constants.Url.seats: NoOfSeatsToBook
//        ]
//        let jsonData = try? JSONSerialization.data(withJSONObject: [Constants.JsonKey.passenger: publish], options: [])
//        var request = URLRequest(url: url)
//        request.httpMethod = Constants.Methods.post
//        request.httpBody = jsonData
//        request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
//
//        if let token = UserDefaults.standard.object(forKey: Constants.Url.token) as? String {
//            request.setValue(token, forHTTPHeaderField: Constants.Url.auth)
//        } else {
//            // Key not found or value not a String
//        }
//
//        URLSession.shared.dataTaskPublisher(for: request)
//            .tryMap { data, response -> Data in
//                guard let httpResponse = response as? HTTPURLResponse else {
//                    throw URLError(.badServerResponse)
//                }
//
//                if (200...299).contains(httpResponse.statusCode) {
//                    print(httpResponse.statusCode)
//                    self.alertSuccessRide.toggle()
//                } else {
//                    print(httpResponse.statusCode)
//                }
//
//                return data
//            }
////            .decode(type: Welcome.self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print("Error: \(error.localizedDescription)")
//                }
//            }, receiveValue: { decodedData in
//                print(decodedData)
//
//            })
//            .store(in: &publishers)
//
//
//
//
//    }
//




}
