//
//  Helper.swift
//  BlaBalApp
//
//  Created by ChicMic on 03/06/23.
//

import Foundation

class Helper {
    func dateFormatter(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormatter.date(from: date) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "HH:mm"
            return outputDateFormatter.string(from: date)
        } else {
            return "Invalid date format"
        }
    }
}
