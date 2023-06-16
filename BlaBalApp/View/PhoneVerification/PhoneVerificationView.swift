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
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @State private var showSuccessView = false
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(Constants.Titles.phnNum).font(.title).fontWeight(.semibold).padding(.bottom, 40)
                CustomTextfield(label: "", placeholder: Constants.Placeholders.phonenumber, value: $vm.phoneNumber).keyboardType(.numberPad).foregroundColor(vm.verified ? .gray : colorScheme == .dark ? Color.white : Color.black).disabled(vm.verified)

                
                     Button {
                         if vm.verified {
                             alertSuccess.toggle()
                             dismiss()
                         } else {
                             if vm.phoneNumber.isEmpty {
                                 alert.toggle()
                             } else {
                                    vm.sendOTP = true
                                    vm.phoneVerify()
                                 if vm.failtToSendOtpAlert {
                                     print("Fail to send otp")
                                 } else {
                                     navigate.toggle()
                                 }
                             }
                         }
                        
                     }label: {
                         Buttons(image: "", text: vm.verified ?  Constants.Buttons.done : "Verify", color: .blue).padding(.top)
                     }
                
                
                
                    
                
                
                Spacer()
      
                if alert {
                    CustomAlert(text: Constants.Alert.emptyfield, dismiss: $alert)
                }
            }.opacity(navigate ? 0.5 : 1).overlay(content: {
                if navigate {
                    ConfirmOTPView( vmm: vm, showview: $navigate)
                }
              
            })
            .onAppear {
                withAnimation {
                    vm.step = 3
                }
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
            PhoneView()
        }
    }
}
