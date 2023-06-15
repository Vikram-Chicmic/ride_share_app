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
    @Published var alertResponse = false
    @Published var decodedVehicleData: VehicleDataModel?
    @Published var isDeletingVehicle = false
    @Published var deletingVehicleId: Int?
    @Published var updatingVehicleId: Int?
    @Published var isUpdatingVehicle: Bool = false
    private var publishers = Set<AnyCancellable>()
    
    // MARK: - Register and Get vehicle
    
    func registerVehicle() {
        guard let url = URL(string: isDeletingVehicle ? Constants.Url.vehicleUrl+"/\(deletingVehicleId!)" : isUpdatingVehicle
                                    ? Constants.Url.vehicleUrl+"/\(updatingVehicleId!)"
                                    : Constants.Url.vehicleUrl) else { return }
      
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
        
        var request = URLRequest(url: url)
        if isRegistering {
            request.httpMethod = Constants.Methods.post
            request.httpBody = jsonData
            request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
        } else if isDeletingVehicle {
                request.httpMethod = Constants.Methods.delete
            } else if isUpdatingVehicle {
                request.httpMethod = Constants.Methods.put
                request.httpBody = jsonData
                request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
            } else {
                request.httpMethod = Constants.Methods.get
            }
        print(url, request.httpMethod)
        
        if let token = UserDefaults.standard.object(forKey: "Token") as? String {
            request.setValue(token, forHTTPHeaderField: "Authorization")
        } else {
            // Key not found or value not a String
        }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode < 300 else {
                    
                    throw URLError(.badServerResponse)
                }
                print(httpResponse.statusCode, url, request.httpMethod)
                return data
            }
            .sink { (completion) in
                print("Completion: \(completion)")
            } receiveValue: { [weak self] data in
                if self?.isRegistering == true {
                    self?.alertResponse.toggle()
                } else {
                    // Handle retrieval of data
                    
                    guard let vehicles = try? JSONDecoder().decode(VehicleDataModel.self, from: data) else {
                        print("Failed to decode response")
                        return
                    }
                    self?.decodedVehicleData = vehicles
                    print(vehicles)
                }
            }
            .store(in: &publishers)
    }

    
    
    

}
