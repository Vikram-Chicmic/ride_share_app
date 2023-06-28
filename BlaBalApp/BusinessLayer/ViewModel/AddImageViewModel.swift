//
//  AddImageViewModel.swift
//  BlaBalApp
//
//  Created by ChicMic on 15/06/23.
//
import Foundation
import Combine
import UIKit

class AddImageViewModel: ObservableObject {

    private var publishers = Set<AnyCancellable>()
    @Published var selectedImage: UIImage?
    @Published var success = false
    @Published var error = false
    @Published var alert = false
    @Published var isLoading = false





    func uploadImage() {
        guard let url = URL(string: Constants.Url.addImage) else {
            print("Invalid URL")
            return
        }

        self.isLoading = true
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"

        let boundary = UUID().uuidString

        let mimeType = "image/jpeg"
        let fileName = "image.jpg"
        let fieldName = "image"

        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        let formData = NSMutableData()

        // Add image field
        formData.appendString("--\(boundary)\r\n")
        formData.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
        formData.appendString("Content-Type: \(mimeType)\r\n\r\n")

        if let imageData = selectedImage?.jpegData(compressionQuality: 0.8) {
            formData.append(imageData)
        }

        formData.appendString("\r\n")

        // Add closing boundary
        formData.appendString("--\(boundary)--\r\n")
        
        if let token = UserDefaults.standard.object(forKey: Constants.Url.token) as? String {
            request.setValue(token, forHTTPHeaderField: Constants.Url.auth)
        } else {
            // Key not found or value not a String
        }
        request.httpBody = formData as Data

        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                // Handle the response
                return data
            }
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                self.alert.toggle()
                switch completion {
                case .finished:
                    self.success.toggle()
                    print("Image upload completed")
                case .failure(let error):
                    self.error.toggle()
                    print("Image upload failed with error: \(error.localizedDescription)")
                }
            }, receiveValue: { responseData in
                // Handle the received data
                print("Response Data: \(responseData)")
            })
            .store(in: &publishers)
    }

    // Helper method to append strings to NSMutableData
   



}
extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            append(data)
        }
    }
}
