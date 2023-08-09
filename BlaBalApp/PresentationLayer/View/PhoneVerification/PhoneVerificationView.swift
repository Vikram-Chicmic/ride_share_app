//
//  PhoneView.swift
//  BlaBalApp
//
//  Created by ChicMic on 12/05/23.
//

import SwiftUI

struct PhoneView: View {
    @EnvironmentObject var vm: LoginSignUpViewModel
    @State var navigate: Bool = false
    @State var navigateToTabView: Bool = false
    @State var alert: Bool = false
    @State var alertSuccess = false
    @State var showAlert = false
    @State var blur: Bool = false
    @State var alertFailSend: Bool = false
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @State private var showSuccessView = false
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(Constants.Titles.phnNum).font(.title).fontWeight(.semibold).padding(.bottom, 40)
                CustomTextfield(label: "", placeholder: Constants.Placeholders.phonenumber, value: $vm.phoneNumber).keyboardType(.numberPad).foregroundColor(vm.phoneVerified ? .gray : colorScheme == .dark ? Color.white : Color.black).disabled(vm.phoneVerified)

                
                     Button {
                         if Helper().isValidIndianPhoneNumber(vm.phoneNumber) {
                             vm.sendOTP = true
                              vm.apiCall(forMethod: .phoneVerify)
                             if vm.failtToSendOtpAlert {
                                 alertFailSend.toggle()
                             } else {
                                 navigate.toggle()
                             }
                             // call phoneverify
                             // if verified then back
                         } else {
                             alert.toggle() // invalid number
                         }
//                         if vm.phoneVerified {
//                             alertSuccess.toggle()
//                             dismiss()
//                         } else {
//                                vm.sendOTP = true
//                                 vm.apiCall(forMethod: .phoneVerify)
//                                 if vm.failtToSendOtpAlert {
//                                     print("Fail to send otp")
//                                 } else {
//                                     navigate.toggle()
//                                 }
//                             }
                         
                        
                     }label: {
                         Buttons(image: "", text: vm.phoneVerified ?  Constants.Buttons.done : "Verify", color: .blue).padding(.top)
                     }

                Spacer()
                
                if alertFailSend {
                    CustomAlert(text: Constants.Alert.failToSendOTP, dismiss: $alertFailSend)
                }
                if alert {
                    CustomAlert(text: Constants.Alert.invalidPhone, dismiss: $alert)
                }
            }.opacity(navigate ? 0.5 : 1)
                .overlay(content: {
                if navigate {
                    ConfirmOTPView( vmm: vm, showview: $navigate)
                }
              
            })
            .onAppear {
                
            }
        .padding()
            
            
             
         
            // ...

            if alertSuccess {
                VStack {
                    Image(systemName: Constants.Icons.checkmark)
                        .foregroundColor(.green)
                        .font(.title)
                    Text(Constants.Alert.numberVerified)
                    Button {
                        dismiss()
                    } label: {
                        Buttons(image: "", text: Constants.Labels.ok, color: Color.green)
                    }

                    
                }
                
            }
       







            
        }
            
        
        
    }
}

struct PhoneView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PhoneView().environmentObject(LoginSignUpViewModel())
        }
    }
}
