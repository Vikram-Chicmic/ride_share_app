//
//  BirthdayView.swift
//  BlaBalApp
//
//  Created by ChicMic on 12/05/23.
//

import SwiftUI

struct BirthdayView: View {
    @EnvironmentObject var vm: LoginSignUpViewModel
    @Binding var selectedDate: Date
    @Binding var alert: Bool
    @Environment(\.dismiss) var dismiss
    let minDate = Calendar.current.date(from: DateComponents(year: 1940, month: 1, day: 1))!
    let maxDate = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 31))!
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                    Text(Constants.Titles.dob).font(.title).fontWeight(.semibold).padding(.bottom, 40)
                    HStack {
                        Text("\(selectedDate, formatter: DateFormatter.custom)")
                        Spacer()
                    }.padding()
                        .background(.gray.opacity(0.2))
                        .cornerRadius(24)
                    HStack {
                        Spacer()
                        Text(Constants.Texts.age).foregroundColor(.gray).font(.subheadline).padding(.trailing)
                    }
                  
    //                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    DatePicker("", selection: $selectedDate,in: minDate...maxDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                                  .padding()
                                  .cornerRadius(25)
             
                    Spacer()
                
                if alert{
                    CustomAlert(text: "Invalid Date", dismiss: $alert)
                }
                }
        } .onDisappear {
            let newDate = Helper().dateToString(selectedDate: selectedDate)
             //TODO: - check if date is valid and custom alert
             vm.bday = newDate
     }.padding()
        
        
    }
}

  struct BirthdayView_Previews: PreviewProvider {
      static var previews: some View {
          BirthdayView(selectedDate: .constant(Date()), alert: .constant(false))
      }
  }
