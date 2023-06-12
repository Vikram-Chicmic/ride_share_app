//
//  DateExtension.swift
//  BlaBalApp
//
//  Created by ChicMic on 11/05/23.
//

import Foundation

extension DateFormatter {
    static let custom: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.Date.dateFormat
        return formatter
    }()
    
    static let dateFormatterWithTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.Date.dateTimeFormat
        return formatter
    }()
}
