//
//  PhoneView.swift
//  BlaBalApp
//
//  Created by ChicMic on 12/05/23.
//

import SwiftUI

struct PhoneView: View {
    @ObservedObject var vm: LoginSignUpViewModel
    @State var navigate: Bool = false
    @State var navigateToTabView: Bool = false
    @State var alert: Bool = false
    @State var blur: Bool = false
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack(alignment: .leading) {
            Text(Constants.Titles.phnNum).font(.title).fontWeight(.semibold).padding(.bottom, 40)
            CustomTextfield(label: "", placeholder: Constants.Placeholders.phonenumber, value: $vm.phoneNumber).keyboardType(.numberPad).foregroundColor(vm.verified ? .gray : colorScheme == .dark ? Color.white : Color.black).disabled(vm.verified)

            
                 Button {
                     if vm.verified {
                         navigateToTabView = true
                     } else {
                         if vm.phoneNumber.isEmpty {
                             alert.toggle()
                         } else {
                                vm.sendOTP = true
                                vm.phoneVerify()
                             navigate.toggle()
                         }
                     }
                    
                 }label: {
                     Buttons(image: "", text: vm.verified ?  Constants.Buttons.done : "Verify", color: .blue).padding(.top)
                 }.fullScreenCover(isPresented: $navigateToTabView) {
                     TabBarView(vm: vm)
                 }
            
            
            Button {
                navigateToTabView = true
            } label: {
                Text("Force Skip")
            }.fullScreenCover(isPresented: $navigateToTabView) {
                TabBarView(vm: vm)
            }

            
            Button {
                dismiss()
            } label: {
                Buttons(image: "", text: Constants.Buttons.back, color: Color(red: 0.742, green: 0.742, blue: 0.754))
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
            
        
        
    }
}

struct PhoneView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PhoneView(vm: LoginSignUpViewModel())
        }
    }
}
