//
//  File.swift
//  BlaBalApp
//
//  Created by ChicMic on 24/05/23.
//

import Foundation
import Combine

class RegisterVehicleViewModel: ObservableObject {
    @Published var selectedCountry = "Afghanistan"
    @Published var selectedVehicleColor = "Black"
    @Published var selectedVehicleType = "Hatchback"
    @Published var madeYear = ""
    @Published var plateNumber = ""
    @Published var vehicleBrand = ""
    @Published var vehicleModel = ""
    @Published var isRegistering = false
    
    @Published var decodedData: VehicleDataModel?

    
    private var publishers = Set<AnyCancellable>()
    
    func registerVehicle() {
        guard let url = URL(string: isRegistering ? Constants.Url.vehicleUrl : Constants.Url.vehicleUrl+"?email=vikram@gmail.com") else { return }
        
        let userData = [
            Constants.Url.country: selectedCountry,
            Constants.Url.vehicleNumber: plateNumber,
            Constants.Url.vehicleBrand: vehicleBrand,
            Constants.Url.vehicleName: vehicleModel,
            Constants.Url.vehicleType: selectedVehicleType,
            Constants.Url.vehicleColor: selectedVehicleColor,
            Constants.Url.model: madeYear
        ] as [String: Any]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: ["vehicle": userData], options: [])
        if let jsonData = jsonData {
            print(jsonData)
        } else {
            print("Cannot convert data to JSON")
            return
        }
        
        var request = URLRequest(url: url)
        if isRegistering {
            request.httpMethod = Constants.Methods.post
            request.httpBody = jsonData
            request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
        } else {
            request.httpMethod = Constants.Methods.get
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: VehicleDataModel.self, decoder: JSONDecoder())
            .sink { (completiion) in
                print("Completion: \(completiion)")
            } receiveValue: { [weak self] vehicles in
                self?.decodedData = vehicles
                print(vehicles)
            }
            .store(in: &publishers)
    }
}
