//
//  BirthdayView.swift
//  BlaBalApp
//
//  Created by ChicMic on 12/05/23.
//

import SwiftUI

struct BirthdayView: View {
    @ObservedObject var vm: LoginSignUpViewModel
    @State private var selectedDate = Date()
    @State var navigate: Bool = false
    @Environment(\.dismiss) var dismiss
    let minDate = Calendar.current.date(from: DateComponents(year: 1940, month: 1, day: 1))!
      let maxDate = Calendar.current.date(from: DateComponents(year: 2015, month: 12, day: 31))!
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
                Button {
                    let formatter = DateFormatter()
                    formatter.dateFormat = Constants.Date.dateFormat
                    vm.bday = formatter.string(from: selectedDate)
                    print(vm.bday)
                    print(selectedDate)
                    navigate.toggle()
                    
                    withAnimation {
                        vm.step += 1
                    }
                    
                }label: {
                    Buttons(image: "", text: Constants.Buttons.cont, color: .blue).padding(.top)
                }
                Button {
                    dismiss()
                } label: {
                    Buttons(image: "", text: Constants.Buttons.back, color: Color(red: 0.742, green: 0.742, blue: 0.754))
                }
                Spacer()
                DatePicker("", selection: $selectedDate, in: minDate...maxDate)
                    .datePickerStyle(.graphical)
                              .padding()
                              .cornerRadius(25)
            } .onAppear {
                withAnimation {
                    vm.step = 1
                }
            }.padding()
            .navigationDestination(isPresented: $navigate) {
                TitleView(vm: vm).navigationBarBackButtonHidden()
        }
        }
        
    }
}

  struct BirthdayView_Previews: PreviewProvider {
      static var previews: some View {
          BirthdayView(vm: LoginSignUpViewModel())
      }
  }
