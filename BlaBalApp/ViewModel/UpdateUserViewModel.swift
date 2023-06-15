//
//  UpdateUserViewModel.swift
//  BlaBalApp
//
//  Created by ChicMic on 01/06/23.
//

import Foundation
import Combine

class UpdateUserViewModel: ObservableObject {
    @Published var oldPassword = ""
    @Published var newPassword = ""
    @Published var confirmNewPassword = ""
    @Published var success: Bool = false
    @Published var response: Welcome?
    
    private var publishers = Set<AnyCancellable>()

    func updatePassword() {
        guard let url = URL(string: Constants.Url.updatePassword) else { return }
        
        let userData = [
            Constants.Url.currentPassword: oldPassword,
            Constants.Url.password: newPassword,
            Constants.Url.confirmPassword: confirmNewPassword
        ] as [String: Any]
        
        print("0rwruwrueiowurwruewjrwejrwkjrwejrwjkrekjrewjrkweljrekwjrwkrjwejk", userData)
        
        let jsonData = try? JSONSerialization.data(withJSONObject: userData, options: [])
       
        if let jsonData = jsonData {
            print(jsonData)
            let decoder = JSONDecoder()
            do {
                let json2 = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
                print(json2)
//                let decodedata = try decoder.decode(Password.self, from: jsonData)
//                    print(decodedata)
            } catch {
                    print("Cant decode")
                }
              
        } else {
            print("Cannot convert data to JSON")
            return
        }
        
        
        
        var request = URLRequest(url: url)
        request.httpMethod = Constants.Methods.patch
        request.httpBody = jsonData
        request.addValue(Constants.Url.appjson, forHTTPHeaderField: Constants.Url.conttype)
        
        if let token = UserDefaults.standard.object(forKey: "Token") as? String {
            request.setValue(token, forHTTPHeaderField: "Authorization")
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
                    print("success")
                    self.success = true
                } else {
//                    self.showAlert = true //cant update
                    print(httpResponse.statusCode)
                }
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                        print(json)
                                    }
                return data
            }
            .decode(type: Welcome.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { decodedData in
                self.response = decodedData
                print(decodedData)
            })
            .store(in: &publishers)
    }
    
}
