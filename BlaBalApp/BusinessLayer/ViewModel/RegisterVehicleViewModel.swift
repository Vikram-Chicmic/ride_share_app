//
//  File.swift
//  BlaBalApp
//
//  Created by ChicMic on 24/05/23.
//

import Foundation
import Combine

class RegisterVehicleViewModel: ObservableObject {
    @Published var selectedCountry = Constants.DefaultValues.country
    @Published var selectedVehicleColor = Constants.DefaultValues.vehicleColor
    @Published var selectedVehicleType = Constants.DefaultValues.vehicleType
    @Published var madeYear = ""
    @Published var plateNumber = ""
    @Published var vehicleBrand = ""
    @Published var vehicleModel = ""
    @Published var isRegistering = false
    @Published var successAlert = false
    @Published var failAlert = false
    @Published var decodedVehicleData: VehicleDataModel?
    @Published var isDeletingVehicle = false
    @Published var deletingVehicleId: Int?
    @Published var updatingVehicleId: Int?
    @Published var isUpdatingVehicle: Bool = false
    @Published var isLoading = false
    @Published var deleteSuccess = false
    @Published var specificVehicleDetails: Datum?
    @Published var getVehicleId: Int = 0
    @Published var updatingRidePublishId: Int = 0
    private var publishers = Set<AnyCancellable>()
    
    
    static var shared = RegisterVehicleViewModel()
    

    // MARK: Function for making API calls
    func apiCall(method: APIcallsForVehicle) {
        switch method {
        case .vehicleRegister:
            ApiManager.shared.apiCallForVehicle(method: .vehicleRegister, request: createRequest(method: .vehicleRegister))
        case .vehicleUpdate:
            ApiManager.shared.apiCallForVehicle(method: .vehicleUpdate, request: createRequest(method: .vehicleRegister))
        case .getVehicle:
            ApiManager.shared.apiCallForVehicle(method: .getVehicle, request: createRequest(method: .getVehicle))
        case .deleteVehicle:
            ApiManager.shared.apiCallForVehicle(method: .deleteVehicle, request: createRequest(method: .deleteVehicle))
        case .getVehicleDetailsById:
            ApiManager.shared.apiCallForVehicle(method: .getVehicleDetailsById, request: createRequest(method: .getVehicleDetailsById))
        }
    }
    
    // MARK: Function to generate JSON for API request
    func getData(method: APIcallsForVehicle) -> [String: Any] {
        switch method {
        case .vehicleRegister, .vehicleUpdate:
            return [Constants.JsonKey.vehicle: [
                Constants.Url.country: selectedCountry,
                Constants.Url.vehicleNumber: plateNumber,
                Constants.Url.vehicleBrand: vehicleBrand,
                Constants.Url.vehicleName: vehicleModel,
                Constants.Url.vehicleType: selectedVehicleType,
                Constants.Url.vehicleColor: selectedVehicleColor,
                Constants.Url.model: madeYear
            ]]
        case .getVehicle, .deleteVehicle, .getVehicleDetailsById:  return [:]
            
        }
    }
    
    // MARK: Function to generate Request
    func createRequest(method: APIcallsForVehicle) -> URLRequest {
        var request: URLRequest
        switch method {
        case .vehicleRegister, .vehicleUpdate:
            request = URLRequest(url: createUrl(method: .vehicleRegister))
            request.httpMethod =  isRegistering ? Constants.Methods.post : Constants.Methods.put
            let jsonData = try? JSONSerialization.data(withJSONObject: getData(method: .vehicleRegister), options: [])
            request.httpBody = jsonData
            request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
            return request
       
        case .getVehicle:
            request = URLRequest(url: createUrl(method: .getVehicle))
            request.httpMethod = Constants.Methods.get
            return request
            
        case .deleteVehicle:
            request = URLRequest(url: createUrl(method: .deleteVehicle))
            request.httpMethod = Constants.Methods.delete
            return request
        case .getVehicleDetailsById:
            request = URLRequest(url: createUrl(method: .getVehicleDetailsById))
            request.httpMethod = Constants.Methods.get
            return request
        }
    }
    
    // MARK: function for Generate url
    func createUrl(method: APIcallsForVehicle) -> URL {
        switch method {
        case .vehicleRegister, .vehicleUpdate, .getVehicle, .deleteVehicle:
            let url = URL(string: Constants.Url.vehicleUrl + (isDeletingVehicle ? "/\(deletingVehicleId!)" : isUpdatingVehicle ? "/\(updatingVehicleId!)" : ""))!
            print(url)
            return url
        
        case .getVehicleDetailsById:
            let url = URL(string: Constants.Url.vehicleUrl+"/\(getVehicleId)")
            return url!
        }
    }
    
    

}
