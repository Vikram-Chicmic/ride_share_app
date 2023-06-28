//
//  Helper.swift
//  BlaBalApp
//
//  Created by ChicMic on 03/06/23.
//

import Foundation

class Helper {
    func estimatedTimeFormatter(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormatter.date(from: date) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "HH:mm"
            return  (outputDateFormatter.string(from: date)+" hours")
        } else {
            return "Invalid date format"
        }
    }
    
    
      func formatDate(_ dateString: String) -> String? {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
          if let date = dateFormatter.date(from: dateString) {
              let formattedDateFormatter = DateFormatter()
              formattedDateFormatter.dateFormat = "EEE, d MMMM, h:mm a"
              formattedDateFormatter.locale = Locale(identifier: "en_US")
              return formattedDateFormatter.string(from: date)
          }
          return nil
      }
    
    func dateToString(selectedDate: Date)-> String{
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.Date.dateFormat
        return formatter.string(from: selectedDate)
    }
    
    func stringTodate(date: String)-> Date {
        let dateFormatter = DateFormatter()
        return dateFormatter.date(from: date) ?? Date()
    }
    
    func formatDateToMMM(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM d, yyyy"
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }
    
    
    func emptyMapAndSearchView() {
        var data = MapAndSearchRideViewModel.shared
        
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
    
    
    
    
    
}
