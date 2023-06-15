//
//  BirthdayView.swift
//  BlaBalApp
//
//  Created by ChicMic on 12/05/23.
//

import SwiftUI

struct BirthdayView: View {
    @EnvironmentObject var vm: LoginSignUpViewModel
    @State private var selectedDate = Date()
    @State var navigate: Bool = false
    @Environment(\.dismiss) var dismiss
    let minDate = Calendar.current.date(from: DateComponents(year: 1940, month: 1, day: 1))!
    let maxDate = Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 31))!
    
    var body: some View {
        ScrollView {
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
                    Text("* minimum age 14 year").foregroundColor(.gray).font(.subheadline).padding(.trailing)
                }
                Spacer()
                DatePicker("", selection: $selectedDate, in: minDate...maxDate)
                    .datePickerStyle(.graphical)
                              .padding()
                              .cornerRadius(25)
            } .onDisappear {
               let newDate = Helper().dateToString(selectedDate: selectedDate)
                vm.bday = newDate
            }.padding()
        }
        
    }
}

  struct BirthdayView_Previews: PreviewProvider {
      static var previews: some View {
          BirthdayView()
      }
  }
