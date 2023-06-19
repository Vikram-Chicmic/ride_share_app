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
    
    private init(){}
    

    
func apiAuthMethod(httpMethod: HttpMethod, method: ApiMethods, dataModel: [String: Any]?, url: URL?) -> AnyPublisher<Welcome?, Error> {
    //JSON to be send with url
        guard let dataModel = dataModel else {
            return Fail(error: AuthenticateError.badConversion)
            .eraseToAnyPublisher()
        }
        //creating url request with json, url, httpmethod
        guard let request = ServiceHelper.shared.setUpApiRequest(url: url, data: dataModel, method: method, httpMethod: httpMethod)
         else {
            return Fail(error: AuthenticateError.badURL)
                .eraseToAnyPublisher()
        }
        
    return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { _ -> AuthenticateError in
                return AuthenticateError.unknown
            }
        
            .tryMap { (data, response) -> (data: Data, response: URLResponse) in

                guard let response = response as? HTTPURLResponse else {
                    throw AuthenticateError.badResponse
                }
                print(response)
                
                if !((200..<299) ~= response.statusCode) {
                    throw try JSONDecoder().decode(ErrorResponse.self, from: data)
                }
                if method.self == .signOut {
                    UserDefaults.standard.set("", forKey: Constants.Url.token)
                }
                else if method.self == .signUp || method.self == .signIn {
                    let bearer = response.value(forHTTPHeaderField: Constants.Url.auth)
                    if let bearer {
                        UserDefaults.standard.set(bearer, forKey: Constants.Url.token)
                    }
                }
                return (data, response)
            }
            .map(\.data)
            .tryMap { data in
                let decoder = JSONDecoder()
                do {
                    switch method {
                    case .emailCheck:
                        let status = Status(code: data.count, error: nil, message: nil, data: nil, imageURL: nil)
                        return Welcome(status: status)
                    case .signOut:
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            // set the status instance
                            print(json)
                            let status = Status(code: json["status"] as? Int ?? 0, error: nil, message: json["message"] as? String, data: nil, imageURL: nil)
                            // return signinlogin model with status instance
                            return Welcome(status: status)
                        }
                    default:
                        UserDefaults.standard.set(data, forKey: Constants.Url.userData)
                    }

                    return try decoder.decode(Welcome.self, from: data)
                } catch {
                    throw AuthenticateError.noData
                }
            }
            .eraseToAnyPublisher()
    }
    
    func apiVehicleMethod<T: Decodable>(httpMethod: HttpMethod, method: ApiVehicleMethods, dataModel: [String:Any]?, url: URL?) -> AnyPublisher <T, Error> {
        
        guard let dataModel = dataModel else {
            return Fail(error: AuthenticateError.badConversion)
            .eraseToAnyPublisher()
        }
        
        guard let request = ServiceHelper.shared.setUpApiRequest(
            url: url,
            data: dataModel,
            method: method,
            httpMethod: httpMethod)
         else {
            // return error if request is nil
            return Fail(error: AuthenticateError.badURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { _ -> AuthenticateError in
                return AuthenticateError.unknown
            }
            .tryMap { (data, response) -> (data: Data, response: URLResponse) in
                
                guard let response = response as? HTTPURLResponse else {
                    throw AuthenticateError.badResponse
                }
                
                if !((200..<299) ~= response.statusCode) {
                    throw try JSONDecoder().decode(ErrorResponse.self, from: data)
                }
                print(response)
                return (data, response)
                
            }
            .map(\.data)
        
            .tryMap { data in
                let decoder = JSONDecoder()
                do {
                    return try decoder.decode(T.self, from: data)
                } catch {
                    throw try decoder.decode(ErrorResponse.self, from: data)
                    //throw AuthenticateError.badConversion
                }
            }
            .eraseToAnyPublisher()

    }
    

}

