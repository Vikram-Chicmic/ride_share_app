//
//  DatePickerTextField.swift
//  EventPlanner
//
//  Created by Chicmic on 26/06/23.
//

import Foundation
import SwiftUI

struct DatePickerTextField: UIViewRepresentable {
    

    private let textField = UITextField()
    private let datePicker = UIDatePicker()
    private let helper = Helper()
    private let dateFormatterForDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  Constants.Date.outputDateFormat
        return dateFormatter
    }()
    
    private let dateFormatterForTime: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter
    }()
    
    public var placeholder: String
    @Binding public var date: Date?
    var pickerType: PickerType
    var isDOB: Bool = false
    let maxDate = Calendar.current.date(from: DateComponents(year: 2008, month: 12, day: 31))!
    let minDate = Calendar.current.date(from: DateComponents(year: 1948, month: 12, day: 31))!
    let maxDate2 = Calendar.current.date(from: DateComponents(year: 2024, month: 12, day: 31))!
    func makeUIView(context: Context) -> UITextField {
        self.datePicker.datePickerMode = self.pickerType == .date ? .date : .time
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self.helper, action: #selector(self.helper.dateValueChanged), for: .valueChanged)
        self.datePicker.minimumDate = isDOB ? minDate : Date()
        self.datePicker.maximumDate = isDOB ? maxDate : maxDate2
        self.textField.placeholder = self.placeholder
        self.textField.inputView = self.datePicker
        textField.tintColor = UIColor.clear
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self.helper, action: #selector(self.helper.doneButtonAction))
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        self.textField.inputAccessoryView = toolbar
        
        self.helper.dateChanged = {
            self.date = self.datePicker.date
        }
        
        self.helper.doneButtonTapped = {
            if self.date == nil {
                self.date = self.datePicker.date
            }
            self.textField.resignFirstResponder()
        }
        
        return self.textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if let selectedDate = self.date {
            uiView.text = self.pickerType == .date ? self.dateFormatterForDate.string(from: selectedDate) : self.dateFormatterForTime.string(from: selectedDate)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Helper {
        public var dateChanged: (() -> Void)?
        public var doneButtonTapped: (() -> Void)?
        
        @objc func dateValueChanged() {
            self.dateChanged?()
        }
        
//        @objc func dateValueChanged() {
//                   // Get the selected date from the date picker
//                   let selectedDate = datePicker.date
//
//                   // Check if the selected date is a future date
//                   if selectedDate > Date() {
//                       // Set the minimum date to the current date and time
//                       datePicker.minimumDate = Date()
//                   } else {
//                       // Set the minimum date to the predefined value (e.g., minDate or minDate2)
//                       datePicker.minimumDate = isDOB ? minDate : minDate2
//                   }
//
//                   self.dateChanged?()
//               }
        
        @objc func doneButtonAction() {
            self.doneButtonTapped?()
        }
    }
    
    class Coordinator {
        
    }
}
