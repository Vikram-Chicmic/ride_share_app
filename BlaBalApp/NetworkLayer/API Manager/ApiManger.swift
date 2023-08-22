//
//  APIService.swift
//  BlaBlaCar
//
//  Created by Pragath on 12/05/23.
//

import Foundation
import Combine
import SwiftUI

class ApiManager {

    static var shared = ApiManager()
    private var authToken: String?

    private init() { }

    private var publishers = Set<AnyCancellable>()

    ///   solo method to call api related to user
    /// - Parameters:
    ///   - method: mehod on the basis of which the api will be perform same method will be passed to success and failure case handler
    ///   - request: request is a urlRequest holding the json to be sent in put and post method , url and mehod of call (put, post, delete, get)
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
                DispatchQueue.main.async {
                    let decoder = JSONDecoder()
                    do {
                        let response = try decoder.decode(ForgotPassword.self, from: data)
                        LoginSignUpViewModel.shared.responseForForgotPassword = response
                        print(response)
                    } catch {
                        print("\(error.localizedDescription)")
                    }
                    
                    if (200...299).contains(response.statusCode) {
                        BaseApiManager.shared.successCaseHandler(method: method, data: data, response: response)
                    } else {
                        BaseApiManager.shared.failureCaseHandler(method: method, data: data, response: response)
                        
                    }
                }
        
                return data
            }
            .decode(type: Welcome.self, decoder: JSONDecoder())
                       .receive(on: RunLoop.main)
                       .sink(receiveCompletion: { completion in
                           DispatchQueue.main.async {
                               LoginSignUpViewModel.shared.isLoading = false
                           }
                        
                           switch completion {
                           case .finished:
                               break
                           case .failure(let error):
                               DispatchQueue.main.async {
                                   withAnimation {
                                       if !error.localizedDescription.isEmpty {
                                           LoginSignUpViewModel.shared.showToast = true
                                           LoginSignUpViewModel.shared.toastMessage = error.localizedDescription
                                       } else {
                                           LoginSignUpViewModel.shared.showToast = false
                                          
                                       }
                                   }
                               }
                            
                           
                               print("Error: \(error.localizedDescription)")
                           }
                       }, receiveValue: {_ in })
                       .store(in: &publishers)
               }

    
    ///   solo method to call api related to vehicles
    /// - Parameters:
    ///   - method: mehod on the basis of which the api will be perform same method will be passed to success and failure case handler
    ///   - request: request is a urlRequest holding the json to be sent in put and post method , url and mehod of call (put, post, delete, get)
    func apiCallForVehicle( method: APIcallsForVehicle, request: URLRequest) {
       var finalRequest = request
       
       if let token = UserDefaults.standard.object(forKey: Constants.Url.token) as? String {
           finalRequest.setValue(token, forHTTPHeaderField: Constants.Url.auth)
       }

        print(finalRequest.url)
        
       return URLSession.shared.dataTaskPublisher(for: finalRequest)
               .tryMap { (data, response) -> Data in
                   guard let response = response as? HTTPURLResponse else {
                       throw AuthenticateError.badResponse
                   }
                   print(response)
                   DispatchQueue.main.async {
                       if (200...299).contains(response.statusCode) {
                           BaseApiManager.shared.successCaseHandleforVehicle(method: method, data: data, response: response)
                       } else {
                           BaseApiManager.shared.failureCaseHandleforVehicle(method: method, data: data, response: response)
                       }
                   }
           
                   return data
               }
                          .receive(on: DispatchQueue.main)
                          .sink(receiveCompletion: { completion in
                              DispatchQueue.main.async {
                                  RegisterVehicleViewModel.shared.isLoading = false
                              }
                              switch completion {
                              case .finished:
                                  break
                              case .failure(let error):
                                  DispatchQueue.main.async {
                                      withAnimation {
                                          if !error.localizedDescription.isEmpty || error.localizedDescription != "The data couldn’t be read because it is missing." {
                                              RegisterVehicleViewModel.shared.showToast = true
                                              RegisterVehicleViewModel.shared.toastMessage = error.localizedDescription
                                          } else {
                                              RegisterVehicleViewModel.shared.showToast = false
                                          }
                                         
                                      }
                                  }
                      
                                  print("Error: \(error.localizedDescription)")
                              }
                          }, receiveValue: {_ in })
                          .store(in: &publishers)
                  }

    
    
    ///   solo method to call api related to rides
    /// - Parameters:
    ///   - method: mehod on the basis of which the api will be perform same method will be passed to success and failure case handler
    ///   - request: request is a urlRequest holding the json to be sent in put and post method , url and mehod of call (put, post, delete, get)
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
                   DispatchQueue.main.async {
                       if (200...299).contains(response.statusCode) {
                           BaseApiManager.shared.successCaseHandleforRides(method: method, data: data, response: response)
                       } else {
                           BaseApiManager.shared.failureCaseHandleForRide(method: method, data: data, response: response)
                       }
                   }
                   return data
               }
               .decode(type: Welcome.self, decoder: JSONDecoder())
               .sink(receiveCompletion: { completion in
                   DispatchQueue.main.async {
                       MapAndRidesViewModel.shared.isLoading = false
                   }
             
                              switch completion {
                              case .finished:
                                  break
                              case .failure(let error):
                                  DispatchQueue.main.async {
                                      withAnimation {
                                          if !error.localizedDescription.isEmpty || error.localizedDescription != "The data couldn’t be read because it is missing." {
                                              MapAndRidesViewModel.shared.showToast = true
                                              MapAndRidesViewModel.shared.toastMessage = error.localizedDescription
                                          } else {
                                              MapAndRidesViewModel.shared.showToast = false
                                          }
                                          
                                      }
                                  }
                                  print("Error: \(error.localizedDescription)")
                              }
                          }, receiveValue: {_ in })
                          .store(in: &publishers)
                  }
    
    ///   solo method to call api related to chats
    /// - Parameters:
    ///   - method: mehod on the basis of which the api will be perform same method will be passed to success and failure case handler
    ///   - request: request is a urlRequest holding the json to be sent in put and post method , url and mehod of call (put, post, delete, get)
    func apiCallForChat( method: APIcallsForChat, request: URLRequest) {
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
                   DispatchQueue.main.async {
                       if (200...299).contains(response.statusCode) {
                           BaseApiManager.shared.successCaseHandlerForChat(method: method, data: data, response: response)
                       } else {
                           BaseApiManager.shared.failureCaseHandlerForChat(method: method, data: data, response: response)
                       }
                   }
           
                   return data
               }
                          .receive(on: DispatchQueue.main)
                          .sink(receiveCompletion: { completion in
                              DispatchQueue.main.async {
                                  ChatViewModel.shared.isLoading = false
                              }
                              switch completion {
                              case .finished:
                                  break
                              case .failure(let error):
                                  DispatchQueue.main.async {
                                      withAnimation {
                                          if !error.localizedDescription.isEmpty || error.localizedDescription != "The data couldn’t be read because it is missing." {
                                              ChatViewModel.shared.showToast = true
                                              ChatViewModel.shared.toastMessage = error.localizedDescription
                                          } else {
                                              ChatViewModel.shared.showToast = false
                                          }
                                       
                                      }
                                  }
                                  print("Error: \(error.localizedDescription)")
                              }
                          }, receiveValue: {_ in })
                          .store(in: &publishers)
                  }
}
