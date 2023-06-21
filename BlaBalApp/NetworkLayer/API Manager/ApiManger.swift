//
//  APIService.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/05/23.
//

import Foundation
import Combine

class ApiManager {

    static var shared = ApiManager()
    private var authToken: String?

    private init() { }

    private var publishers = Set<AnyCancellable>()

 func apiAuthMethod( method: APIcallsForUser, request: URLRequest) {
    var finalRequest = request
    
    if let token = UserDefaults.standard.object(forKey: Constants.Url.token) as? String {
        finalRequest.setValue(token, forHTTPHeaderField: Constants.Url.auth)
    }

    return URLSession.shared.dataTaskPublisher(for: finalRequest)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse else {
                    throw AuthenticateError.badResponse
                }
                print(response)
                if (200...299).contains(response.statusCode) {
                    BaseApiManager.shared.successCaseHandler(method: method, data: data, response: response)
                } else {
                    BaseApiManager.shared.failureCaseHandler(method: method, data: data, response: response)
                }
                return data
            }
            .decode(type: Welcome.self, decoder: JSONDecoder())
                       .receive(on: RunLoop.main)
                       .sink(receiveCompletion: { completion in
                           LoginSignUpViewModel.shared.isLoading = false
                           switch completion {
                           case .finished:
                               break
                           case .failure(let error):
                               print("Error: \(error.localizedDescription)")
                           }
                       }, receiveValue: {_ in })
                       .store(in: &publishers)
               }

    
    func apiCallForVehicle( method: APIcallsForVehicle, request: URLRequest) {
       var finalRequest = request
       
       if let token = UserDefaults.standard.object(forKey: Constants.Url.token) as? String {
           finalRequest.setValue(token, forHTTPHeaderField: Constants.Url.auth)
       }

       return URLSession.shared.dataTaskPublisher(for: finalRequest)
               .tryMap { (data, response) -> Data in
                   guard let response = response as? HTTPURLResponse else {
                       throw AuthenticateError.badResponse
                   }
                   print(response)
                   if (200...299).contains(response.statusCode) {
                       BaseApiManager.shared.successCaseHandleforVehicle(method: method, data: data, response: response)
                   } else {
                       BaseApiManager.shared.failureCaseHandleforVehicle(method: method, data: data, response: response)
                   }
                   return data
               }
               .decode(type: Welcome.self, decoder: JSONDecoder())
                          .receive(on: DispatchQueue.main)
                          .sink(receiveCompletion: { completion in
                              LoginSignUpViewModel.shared.isLoading = false
                              switch completion {
                              case .finished:
                                  break
                              case .failure(let error):
                                  print("Error: \(error.localizedDescription)")
                              }
                          }, receiveValue: {_ in })
                          .store(in: &publishers)
                  }

    func apiCallForRides( method: APIcallsForRides, request: URLRequest) {
       var finalRequest = request
       
       if let token = UserDefaults.standard.object(forKey: Constants.Url.token) as? String {
           finalRequest.setValue(token, forHTTPHeaderField: Constants.Url.auth)
       }

       return URLSession.shared.dataTaskPublisher(for: finalRequest)
               .tryMap { (data, response) -> Data in
                   guard let response = response as? HTTPURLResponse else {
                       throw AuthenticateError.badResponse
                   }
                   print(response)
                   if (200...299).contains(response.statusCode) {
                       BaseApiManager.shared.successCaseHandleforRides(method: method, data: data, response: response)
                   } else {
                       BaseApiManager.shared.failureCaseHandleForRide(method: method, data: data, response: response)
                   }
                   return data
               }
               .decode(type: Welcome.self, decoder: JSONDecoder())
                          .receive(on: DispatchQueue.main)
                          .sink(receiveCompletion: { completion in
                              LoginSignUpViewModel.shared.isLoading = false
                              switch completion {
                              case .finished:
                                  break
                              case .failure(let error):
                                  print("Error: \(error.localizedDescription)")
                              }
                          }, receiveValue: {_ in })
                          .store(in: &publishers)
                  }
    
    
    
    
    
    
//    func apiVehicleMethod<T: Decodable>( method: APIcallsForVehicle, dataModel: [String:Any]?, url: URL?) -> AnyPublisher <T, Error> {
//
//        guard let dataModel = dataModel else {
//            return Fail(error: AuthenticateError.badConversion)
//            .eraseToAnyPublisher()
//        }
//
//        guard let request = ServiceHelper.shared.setUpApiRequest(
//            url: url,
//            data: dataModel,
//            method: method)
//         else {
//            // return error if request is nil
//            return Fail(error: AuthenticateError.badURL)
//                .eraseToAnyPublisher()
//        }
//
//        return URLSession.shared.dataTaskPublisher(for: request)
//            .mapError { _ -> AuthenticateError in
//                return AuthenticateError.unknown
//            }
//            .tryMap { (data, response) -> (data: Data, response: URLResponse) in
//
//                guard let response = response as? HTTPURLResponse else {
//                    throw AuthenticateError.badResponse
//                }
//
//                if !((200..<299) ~= response.statusCode) {
//                    throw try JSONDecoder().decode(ErrorResponse.self, from: data)
//                }
//                print(response)
//                return (data, response)
//
//            }
//            .map(\.data)
//
//            .tryMap { data in
//                let decoder = JSONDecoder()
//                do {
//                    return try decoder.decode(T.self, from: data)
//                } catch {
//                    throw try decoder.decode(ErrorResponse.self, from: data)
//                    //throw AuthenticateError.badConversion
//                }
//            }
//            .eraseToAnyPublisher()
//
//    }


}

