//
//  ServiceHelper.swift
//  BlaBalApp
//
//  Created by ChicMic on 19/06/23.
//

import Foundation



class ServiceHelper {
    
    static let shared = ServiceHelper()
    
    private init() {}
    
    func setUpApiRequest<T: RawRepresentable>(url: URL?, data: [String: Any], method: T, httpMethod: HttpMethod) -> URLRequest? where T.RawValue == String {

        guard let url = url else {
            return nil
        }


        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.trimmingCharacters(in: .whitespaces)
        if let tokenValue = UserDefaults.standard.string(forKey: Constants.Url.token) {
            if !tokenValue.isEmpty {
                request.setValue(tokenValue, forHTTPHeaderField: Constants.Url.auth)
            }
        }
        if httpMethod != .GET {
            request.setValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
            let jsonData = try? JSONSerialization.data(withJSONObject: data, options: .fragmentsAllowed)
            request.httpBody = jsonData
        }
        return request
    }
    
}