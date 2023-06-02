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
    
//    func getLatLong() {
//        guard !searchText.isEmpty else {
//            // Empty search text, reset the data or perform necessary actions
//            return
//        }
//
//        let url = URL(string: "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=formatted_address%2Cgeometry&input=\(searchText)&inputtype=textquery&key=AIzaSyDUzn63K64-sXadyIwRJExCfMaicagwGq4")!
//
//        // Cancel the previous search request
//        searchCancellable?.cancel()
//
//        // Delay the request by 0.5 seconds using debounce
//        searchCancellable = URLSession.shared.dataTaskPublisher(for: url)
//            .map(\.data)
//            .decode(type: GoogleLatLongModel.self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print("Error: \(error.localizedDescription)")
//                }
//            }, receiveValue: { data in
//                self.searchResultArr = data
//                print(data)
//            })
//
//        // Debounce the search text changes by 0.5 seconds
//        $searchText
//            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
//            .sink { [weak self] searchText in
//                self?.getLatLong()
//            }
//            .store(in: &publishers)
//    }
    
  

    
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

}
