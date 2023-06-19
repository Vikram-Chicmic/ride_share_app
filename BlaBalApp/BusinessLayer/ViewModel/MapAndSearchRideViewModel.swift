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
    @Published var alertSuccess = false
    @Published var alertSuccessRide = false
    private let apiKey = Constants.API.apiKey
    
    func fetchPlaces() {
        guard let url = createURL(for: searchText) else {
            return
        }
        
        let request = URLRequest(url: url)
        
      
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: PlacesResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            } receiveValue: { response in
                // Handle the received response containing place data
                print(response)
                self.searchResultArr = response
            }
            .store(in: &publishers)
    }
    
    private func createURL(for query: String) -> URL? {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = Constants.Url.mapUrl+"\(encodedQuery)&key=\(apiKey)"
        return URL(string: urlString)
    }
    
    func publishRide() {
        guard let url = URL(string: Constants.Url.publishRide ) else { return }
        let publish = [
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
        ] as [String: Any]
        
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: [Constants.JsonKey.publish: publish], options: [])
        if let jsonData = jsonData {
            print(jsonData)
        } else {
            print(Constants.Errors.cantConvertJson)
            return
        }
    

        var request = URLRequest(url: url)
        request.httpMethod = Constants.Methods.post
        request.httpBody = jsonData
        request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
        
        if let token = UserDefaults.standard.object(forKey: Constants.Url.token) as? String {
            request.setValue(token, forHTTPHeaderField: Constants.Url.auth)
        } else {
            // Key not found or value not a String
        }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }

                if (200...299).contains(httpResponse.statusCode) {
                    print(httpResponse.statusCode)
                    self.alertSuccess.toggle()
                } else {
                    print(httpResponse.statusCode)
                }
                
                return data
            }
            .decode(type: SearchRideResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { decodedData in
                print(decodedData)
                // Assuming you have the JSON data stored in a variable called jsonData
//                self.encodeData(recievedData: decodedData)
//                self.decodeData()

            })
            .store(in: &publishers)
    }
    
    
    func bookRide(publishId: Int, seats: Int) {
        guard let url = URL(string: Constants.Url.bookRide) else { return }
        
        let publish = [
            Constants.Url.publishId: publishId,
            Constants.Url.seats: seats
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: [Constants.JsonKey.passenger: publish], options: [])
        var request = URLRequest(url: url)
        request.httpMethod = Constants.Methods.post
        request.httpBody = jsonData
        request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
        
        if let token = UserDefaults.standard.object(forKey: Constants.Url.token) as? String {
            request.setValue(token, forHTTPHeaderField: Constants.Url.auth)
        } else {
            // Key not found or value not a String
        }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }

                if (200...299).contains(httpResponse.statusCode) {
                    print(httpResponse.statusCode)
                    self.alertSuccessRide.toggle()
                } else {
                    print(httpResponse.statusCode)
                }
                
                return data
            }
//            .decode(type: Welcome.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { decodedData in
                print(decodedData)

            })
            .store(in: &publishers)
        
        
        

    }
    
    func searchRide() {
        let url = generateURL()
        guard let url = URL(string: url) else {
            return
        }
        var request = URLRequest(url: url)
        if let token = UserDefaults.standard.object(forKey: Constants.Url.token) as? String {
            request.setValue(token, forHTTPHeaderField: Constants.Url.auth)
        } else {
            // Key not found or value not a String
        }
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                print(httpResponse.statusCode)
                return data
            }.receive(on: DispatchQueue.main)
            .sink { (completion) in
                print("Completion: \(completion)")
            } receiveValue: { [weak self] data in
                guard let respones = try? JSONDecoder().decode(SearchRideResponse.self, from: data) else {
                    print(Constants.Errors.decodeerror)
                    return
                }
                print(respones.data)
                self?.searchRideResult = respones.data
            }
        .store(in: &publishers)
    
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


}
