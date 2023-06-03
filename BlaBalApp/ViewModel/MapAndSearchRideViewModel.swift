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
//    @Published var sourceLong = "30.7132678"
//    @Published var sourceLat  = "76.6910316"
//    @Published var destLong   = "82.9739144"
//    @Published var destLat    = "25.3176452"
    @Published var passengers = 1
    @Published var date       = ""
    
    @Published var originData : Result?
    @Published var destinationData: Result?
    @Published var searchRideResult: [SearchRideResponseData]?

    private let apiKey = "AIzaSyDUzn63K64-sXadyIwRJExCfMaicagwGq4"
    
    func fetchPlaces() {
        guard let url = createURL(for: searchText) else {
            print("Invalid URL")
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
        let urlString = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(encodedQuery)&key=\(apiKey)"
        return URL(string: urlString)
    }
    
    func searchRide(){
        let url = generateURL()
        guard var url = URL(string: url) else {
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
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
                    print("Failed to decode response")
                    return
                }
                print(respones.data)
                self?.searchRideResult = respones.data
            }
        .store(in: &publishers)
    
    }
        
    
   
    func generateURL()-> String {
        var url = "https://0610-112-196-113-2.ngrok-free.app/search"
        if let og = originData?.geometry.location, let dt = destinationData?.geometry.location {
            
            url += "?source_longitude=\(og.lng)"
            url += "&source_latitude=\(og.lat)"
            url += "&destination_longitude=\(dt.lng)"
            url += "&destination_latitude=\(dt.lat)"
            url += "&passengers_count=\(passengers)"
            url += "&date=\(date)"
            print(url)
        }
        
        return url
    }


}
