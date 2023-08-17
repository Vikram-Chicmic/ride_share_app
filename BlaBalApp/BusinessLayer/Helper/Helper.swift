//
//  Helper.swift
//  BlaBalApp
//
//  Created by ChicMic on 03/06/23.
//

import Foundation
import SwiftUI

class Helper {
    
    ///  mehod to format the estimated time
    /// - Parameter date: date is the date provided by api in string format
    /// - Returns: returns the formatted date in string format
    func estimatedTimeFormatter(timestamp: String) -> String? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate, .withTime, .withTimeZone, .withDashSeparatorInDate, .withColonSeparatorInTime]

        if let date = dateFormatter.date(from: timestamp) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour, .minute, .second], from: date)
            
            if let hour = components.hour, let minute = components.minute, let second = components.second {
                return String(format: "%02d:%02d:%02d", hour, minute, second)
            }
        }
        
        return nil
    }
    

    
    ///   mehod to validate name
    /// - Parameter name: string value get from textfield
    /// - Returns: return true or false value based on validation , return true if it is invalid otherwise false
    func nameValidation(name: String) -> Bool {
        if name.isEmpty { return true}
        if name.containsSpecialCharacters { return true}
        if name.containsNumbers { return true}
        if name.containsWhitespace { return true}
        return false
    }
    
    func colorSelector(status: String) -> Color {
        if status == "pending" { return .orange}
        if status == "completed" { return .green}
        if status == "cancelled" { return .red}
        return .blue
    }
    
    func datetimeFormat(dateTime: String, format: String) -> String {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            
            let myTime = dateFormatter.date(from: dateTime)
            
            guard let time = myTime else {
                return ""
            }
            
            dateFormatter.dateFormat = format
            let tme = dateFormatter.string(from: time)
            return tme
        }
    

    
    func setRideDetailsInEditMode(data: AllPublishRideData){
        MapAndRidesViewModel.shared.publishId = data.id
        MapAndRidesViewModel.shared.updatedOriginName = data.source
        MapAndRidesViewModel.shared.updatedDestinationName = data.destination
        MapAndRidesViewModel.shared.updatedOriginLong = data.sourceLongitude
        MapAndRidesViewModel.shared.updatedOriginLat = data.sourceLongitude
        MapAndRidesViewModel.shared.updatedDestinationLat = data.destinationLatitude
        MapAndRidesViewModel.shared.updatedDestinationLong = data.destinationLongitude
        MapAndRidesViewModel.shared.passengers = data.passengersCount
        MapAndRidesViewModel.shared.date = data.date
        MapAndRidesViewModel.shared.time = data.time
        MapAndRidesViewModel.shared.amount = String(data.setPrice)
        MapAndRidesViewModel.shared.vehicleId = data.vehicleID
        MapAndRidesViewModel.shared.aboutRide = data.aboutRide
        MapAndRidesViewModel.shared.estimatedTime = data.estimateTime
    }
    
    ///  method to fomat date into date string
    /// - Parameter dateString: recieve date into string format in timezone format
    /// - Returns: return simplified date in string format
      func formatDate(_ dateString: String) -> String? {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = Constants.Date.estimatedTimeformat
          if let date = dateFormatter.date(from: dateString) {
              let formattedDateFormatter = DateFormatter()
              formattedDateFormatter.dateFormat = Constants.Date.dateFormat2
              formattedDateFormatter.locale = Locale(identifier: Constants.Date.dateIdentifier)
              return formattedDateFormatter.string(from: date)
          }
          return nil
      }
    
    /// to set first view of tab always when login or signup after logout
     struct TabState: EnvironmentKey {
        // 1
         static let defaultValue: Tabs = .searchView
    }
 
  
    ///  method to convert date into string
    /// - Parameter selectedDate: accept date
    /// - Returns: return date in string format
    func dateToString(selectedDate: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.Date.dateFormat
        return formatter.string(from: selectedDate)
    }
    
    
    
    ///  method to convert string formatted date into date
    /// - Parameter date: accept date in string format
    /// - Returns: return formatted date
    func stringTodate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.Date.stringToDateForamat
        return dateFormatter.date(from: date) ?? Date()
    }
    
    ///  method to change the display format  of date
    /// - Parameter dateString: accept date in string format
    /// - Returns: return string format date of MMM, d, yyyy
    func formatDateToMMM(_ dateString: String, dateFormat: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = dateFormat
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = Constants.Date.outputDateFormat
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return Constants.Error.invalidDateFormat
        }
    }
    
    
    ///  mehtod to empty the model for mapandSearchViewModel
    func emptyMapAndSearchView() {
        let data = MapAndRidesViewModel.shared
        data.time = ""
        data.passengers = 1
        data.aboutRide = ""
        data.amount = "0"
        data.originData?.name = ""
        data.destinationData?.name = ""
        data.noOfSeatsToBook = 0
        data.polylineString = ""
        data.passengerId = 0
    }
    
    
    /// funciton to valid phone number
    /// - Parameter phoneNumber: phone number in string
    /// - Returns: boolean which indicates wether the number is valid or not
    func isValidIndianPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneRegex = #"^\d{10}$"#
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phoneNumber)
    }
    
    
    func optionButton(for option: Option) -> some View {
        Button {
            option.isPresented.toggle()
        } label: {
            HStack {
                Text(option.title)
                Spacer()
                Image(systemName: Constants.Icons.rightChevron)
            }
        }
        .navigationDestination(isPresented: option.$isPresented) {
            option.destination
        }
        .padding()
    }
    
    public struct Option {
         let title: String
         let destination: AnyView
         @Binding var isPresented: Bool
     }
    
    
    
    
    
    
    var message: [[String: Any]] = [        [
        "id": 270,
        "content": "Ggb",
        "sender_id": 4,
        "receiver_id": 249,
        "created_at": "2023-06-27T12:24:27.387Z",
        "updated_at": "2023-06-27T12:24:27.387Z",
        "chat_id": 45
    ],
    [
        "id": 216,
        "content": "Gh",
        "sender_id": 4,
        "receiver_id": 249,
        "created_at": "2023-06-27T04:52:15.241Z",
        "updated_at": "2023-06-27T04:52:15.241Z",
        "chat_id": 45
    ],
    [
        "id": 203,
        "content": "Hello",
        "sender_id": 4,
        "receiver_id": 249,
        "created_at": "2023-06-26T05:05:56.517Z",
        "updated_at": "2023-06-26T05:05:56.517Z",
        "chat_id": 45
    ],
    [
        "id": 186,
        "content": "Aaj ka taza khabar",
        "sender_id": 4,
        "receiver_id": 249,
        "created_at": "2023-06-23T06:31:44.279Z",
        "updated_at": "2023-06-23T06:31:44.279Z",
        "chat_id": 45
    ]]
}
