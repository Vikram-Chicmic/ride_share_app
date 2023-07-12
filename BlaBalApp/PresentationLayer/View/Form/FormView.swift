//
//  FormView.swift
//  BlaBalApp
//
//  Created by ChicMic on 14/06/23.
//
import SwiftUI

struct FormView: View {
    @State private var step = 0
    @EnvironmentObject var vm: LoginSignUpViewModel
    @State var alert: Bool =  false
    @State var selectedDate: Date? = Calendar.current.date(from: DateComponents(year: 2008, month: 12, day: 31))!
  
    var body: some View {
        VStack {
            CustomProgressBar(step: $step).padding(.top)
            
            VStack {
                if step == 0 {
                    NameView(alert: $alert)
                } else if step == 1 {
                    BirthdayView(selectedDate: $selectedDate, alert: $alert)
                } else if step == 2 {
                    TitleView(alert: $alert)
                }
            }
            
            Spacer()
            VStack {
                Button {
                    hideKeyboard()
                    if step == 0 {
                      
                        if Helper().nameValidation(name: vm.fname) || Helper().nameValidation(name: vm.lname) {
                            alert.toggle()
                        }
                       
                    }
                    
                    if step == 1 {
                            let currentDate = Date()
                            let calendar = Calendar.current
                        let selectedYear = calendar.component(.year, from: selectedDate ?? Date())
                            let currentYear = calendar.component(.year, from: currentDate)
                            let age = currentYear - selectedYear
                            
                            if age >= 15 {
                                let newDate = Helper().dateToString(selectedDate: selectedDate ?? Date())
                                vm.bday = newDate
                            } else {
                                alert.toggle()
                              
                            }
                    }
                    
                    if step == 2 {
                        if vm.selectedTitle.isEmpty {
                                alert.toggle()
                                    } else {
                                        vm.apiCall(forMethod: .signUp)
                                        }
                    }

                    if !alert {
                        withAnimation {
                            if step < 2 {
                                step += 1 // Move to the next view
                            }
                        }
                    }
                    
                } label: {
                    Buttons(image: "", text: Constants.Buttons.cont, color: .blue)
                }.disabled(alert)
                Button {
                    withAnimation {
                        if step > 0 {
                            step -= 1 // Move to the previous view
                        }
                    }
                } label: {
                    if step>0 {
                        Buttons(image: "", text: Constants.Buttons.back, color: .gray.opacity(0.5))
                    }
                }.padding(.bottom)

            }.padding(.horizontal)

        }.navigationBarBackButtonHidden(true)
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView().environmentObject(LoginSignUpViewModel())
    }
}
