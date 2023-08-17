//
//  MapAndSearchRideViewModel.swift
//  BlaBalApp
//
//  Created by ChicMic on 02/06/23.
//

import Combine
import Foundation

class MapAndRidesViewModel: ObservableObject {
    
    @Published var searchText                                               = ""
    private var publishers                                                  = Set<AnyCancellable>()
    @Published var passengers                                               = 1
    @Published var date                                                     = ""
    @Published var time                                                     = ""
    @Published var aboutRide                                                = ""
    @Published var amount: String                                           = ""
    @Published var vehicleId: Int                                           = 0
    @Published var estimatedTime: String                                    = ""
    @Published var estimatedDistance: String                                = ""
    @Published var alertSuccess                                             = false
    @Published var updateRideSuccess                                        = false
    @Published var alertFailure                                             = false
    @Published var alertBookRideFailure                                     = false
    @Published var alertBookRideSuccess                                     = false
    @Published var alertForPublish                                          = false
    @Published var alertFetchPublishedRideFailure                           = false
    @Published var alertFetchBookedRideFailure                              = false
    @Published var publishId                                                = 0
    @Published var noOfSeatsToBook                                          = 0
    @Published var polylineString: String                                   = ""
    private let apiKey                                                      = Constants.API.apiKey
    @Published var passengerId: Int                                         = 0
    @Published var isLoading                                                = false
    @Published var alertCancelRide                                          = false
    @Published var updatedOriginName: String?
    @Published var updatedOriginLong: Double?
    @Published var updatedOriginLat: Double?
    @Published var updatedDestinationName: String?
    @Published var updatedDestinationLong: Double?
    @Published var updatedDestinationLat: Double?
    @Published var updatedSeats: Int?
    @Published var updatedBio: String?
    @Published var updatedPrice: Int?
    @Published var updatedDate: Date?
    @Published var updatedTime: Date?
    @Published var updatedVehicleId: Int?
    @Published var updatedEstimatedTime: String?
    @Published var isUpdatedSuccess = false
    
    @Published var estimatedTimeInSeconds: Int?
    static var shared = MapAndRidesViewModel()
    @Published var allPublishRides: [AllPublishRideData]?
    @Published var allBookedRides: AllBookedRide?
    @Published var originData: Result?
    @Published var destinationData: Result?
    
    @Published var isUpdatedSource = false
    @Published var isUpdatedDestination = false
    
    private var searchCancellable: AnyCancellable?
    @Published var searchResultArr: PlacesResponse?
    @Published var searchRideResult: [SearchRideResponseData]?
    
    
    
    private func createURL(for query: String) -> String {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = Constants.Url.mapUrl+"\(encodedQuery)&key=\(apiKey)"
        return urlString
    }
    
    
    // MARK: function for Generate url
    ///  mehtod to generate url
    /// - Parameter method: accept  a method to generate url for  api call
    /// - Returns: return url
    func createUrl(method: APIcallsForRides) -> URL {
        switch method {
        case .publishRide, .getAllPublisghRideOfCurrentUser:
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
            return URL(string: Constants.Url.publishRide+"/\(publishId)")!
        case .cancelRide:
            return URL(string: Constants.Url.cancelRide)!
        case .getAllBookedRideOfCurentUser:
            return URL(string: Constants.Url.getBookedRides)!
        case .cancelBookedRide:
            return URL(string: Constants.Url.cancelBookedRide)!
        }
    }
    
    
    ///  mehtod to genrate url for a google api request to get info about the distance and estimated time between two location
    /// - Returns: return a string url
    func generateUrlForFetchPublishRideDetails() -> String {
        let url: String
        if let originData1 = originData?.geometry.location, let destinationData1 = destinationData?.geometry.location {
            url = "\(Constants.Url.fetchPublishRideUrl)\(originData1.lat),\(originData1.lng)&destination=\(destinationData1.lat),\(destinationData1.lng)&key=\(Constants.API.apiKey)"
            return url
        }
        return ""
    }
    
    
    
    // MARK: Function to generate JSON for API request
    ///  method to create json for api put and post calls
    /// - Parameter method: mehod to generate speciffic json for specific call
    /// - Returns: return a dictionary
    func generateJSONfor(mehod: APIcallsForRides) -> [String: Any] {
        switch mehod {
        case .publishRide, .updateRide:
            return [Constants.JsonKey.publish: [
                Constants.Url.source: isUpdatedSource ? originData?.name as Any : updatedOriginName as Any,
                Constants.Url.sourceLong: isUpdatedSource ? originData?.geometry.location.lng  as Any : updatedOriginLong  as Any,
                Constants.Url.sourceLat: isUpdatedSource ? originData?.geometry.location.lat  as Any : updatedOriginLat  as Any,
                Constants.Url.destination: isUpdatedDestination ? destinationData?.name as Any : updatedDestinationName as Any,
                Constants.Url.destLong: isUpdatedDestination ? destinationData?.geometry.location.lng  as Any : updatedDestinationLong as Any,
                Constants.Url.destLat: isUpdatedDestination ? destinationData?.geometry.location.lat  as Any : updatedDestinationLat as Any,
                Constants.Url.passengerCount: Int(passengers),
                Constants.Url.date: date,
                Constants.Url.time: time,
                Constants.Url.setPrice: Double(amount)  as Any,
                Constants.Url.vehicleId: vehicleId,
                Constants.Url.aboutRide: aboutRide,
                Constants.Url.estimateTime: estimatedTime
            ] ]

        case .bookRide:
            return  [Constants.JsonKey.passenger: [
                Constants.Url.publishId: publishId,
                Constants.Url.seats: noOfSeatsToBook
            ]]
        case .searchRide, .fetchPlaces, .getAllBookedRideOfCurentUser, .fetchPolylineAndDistanceOfRide,.getAllPublisghRideOfCurrentUser:
            return [:]
        case .cancelRide:
            return ["id": publishId]
        case .cancelBookedRide:
            print(["id": passengerId])
            return ["id": passengerId]
        }
    }
    
    
    // MARK: Function to generate Request
    ///  method to create a urlrequest for api call
    /// - Parameter method: accept a method to generate url reqeust for a specific type  of api call
    /// - Returns: return a url request based on api call
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
            let request = URLRequest(url: createUrl(method: .searchRide))
            return request
      
        case .fetchPlaces:
            let request = URLRequest(url: createUrl(method: .fetchPlaces))
            return request
            
        case .fetchPolylineAndDistanceOfRide:
            var request = URLRequest(url: createUrl(method: .fetchPolylineAndDistanceOfRide))
            request.httpMethod = Constants.Methods.get
            return request
        case .getAllPublisghRideOfCurrentUser:
            var request = URLRequest(url: createUrl(method: .getAllPublisghRideOfCurrentUser))
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
        case .getAllBookedRideOfCurentUser:
            var request = URLRequest(url: createUrl(method: .getAllBookedRideOfCurentUser))
            request.httpMethod = Constants.Methods.get
            return request
            
        case .cancelBookedRide:
            var request = URLRequest(url: createUrl(method: .cancelBookedRide))
            request.httpMethod = Constants.Methods.post
            let jsonData = try? JSONSerialization.data(withJSONObject: generateJSONfor(mehod: .cancelBookedRide), options: [])
            request.httpBody = jsonData
            request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
            return request
        }
    }
    
    
    // MARK: Function for making API calls
    ///  method to perform api call
    /// - Parameter method: accept a method for api call from enum
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
        case .getAllPublisghRideOfCurrentUser:
            ApiManager.shared.apiCallForRides(method: .getAllPublisghRideOfCurrentUser, request: createRequest(method: .getAllPublisghRideOfCurrentUser))
        case .updateRide:
            ApiManager.shared.apiCallForRides(method: .updateRide, request: createRequest(method: .updateRide))
        case .cancelRide:
            ApiManager.shared.apiCallForRides(method: .cancelRide, request: createRequest(method: .cancelRide))
        case .getAllBookedRideOfCurentUser:
            ApiManager.shared.apiCallForRides(method: .getAllBookedRideOfCurentUser, request: createRequest(method: .getAllBookedRideOfCurentUser))
        case .cancelBookedRide:
            ApiManager.shared.apiCallForRides(method: .cancelBookedRide, request: createRequest(method: .cancelBookedRide))
        }
    }
    
    
    
    /// function to generate a url for  a get request of ride
    func generateURL() -> String {
            var url = Constants.Url.searchRide
            if let og = originData?.geometry.location, let dt = destinationData?.geometry.location {
                url += Constants.Url.srcLong+"\(og.lng)"
                url += Constants.Url.srcLat+"\(og.lat)"
                url += Constants.Url.desLong+"\(dt.lng)"
                url += Constants.Url.desLat+"\(dt.lat)"
                url += Constants.Url.passCount+"\(passengers)"
                url += Constants.Url.dateUrl+"\(date)"
//                print(url)
            }
            return url
        }

}
