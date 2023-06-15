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
    @State private var selectedDate = Date()
    var body: some View {
        VStack {
            CustomProgressBar(step: $step)
            
            VStack {
                if step == 0 {
                    NameView(vm: _vm)
                } else if step == 1 {
                    BirthdayView(vm: _vm)
                } else if step == 2 {
                    TitleView(vm: _vm)
                }
            }
            
            Spacer()
            if alert {
                CustomAlert(text: Constants.Alert.emptyfield, dismiss: $alert)
               }
            
            VStack {
                Button {
                    withAnimation {
                        if step < 2 {
                            step += 1 // Move to the next view
                        }
                    }
                    
                    if step == 0 {
                        if vm.lname.isEmpty || vm.fname.isEmpty {
                            alert.toggle()
                        }
                    }
                    
                    if step == 1 {
                 
                        //open calandar
                    }
                    
                    if step == 2 {
                        if vm.selectedTitle.isEmpty {
                            alert.toggle()
                        } else {
                            vm.signUp()
                        }
                    }
                    
                } label: {
                    Buttons(image: "", text: Constants.Buttons.cont, color: .blue)
                }
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
                }

            }.padding(.horizontal)

        }.navigationBarBackButtonHidden(true)
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
