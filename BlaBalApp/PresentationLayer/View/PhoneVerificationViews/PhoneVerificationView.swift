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
    @State var otpHasBeenSent = false
    @State var sendOtp = true
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var networkStatusManager: NetworkStatusManager
    @Environment(\.colorScheme) var colorScheme
    @State private var showSuccessView = false
    var body: some View {
        VStack {
            
        
        VStack(alignment: .leading) {
            Text(Constants.Titles.phnNum).font(.title).fontWeight(.semibold).padding(.bottom, 20)
            CustomTextfield(label: "", placeholder: Constants.Placeholders.phonenumber, value: $vm.phoneNumber).keyboardType(.numberPad).disabled(vm.otpSended)
            
            if vm.otpSended {
                CustomTextfield(label: "", placeholder: "Enter 4 digit OTP", value: Binding(
                    get: { vm.passcode },
                    set: { newValue in
                        let truncatedValue = String(newValue.prefix(4))
                        vm.passcode = truncatedValue
                    }
                )).padding(.bottom)
            }
            
            Button {
                if vm.otpSended {
                    if vm.passcode.isEmpty {
                        alert.toggle()
                    } else {
                        vm.apiCall(forMethod: .otpVerify)
                    }
                } else {
                    if Helper().isValidIndianPhoneNumber(vm.phoneNumber)  {
                        vm.apiCall(forMethod: .phoneVerify)
                    } else {
                        alert.toggle() // invalid number
                    }
                }
                
            } label: {
                Buttons(image: "", text: vm.otpSended ? "Verify OTP" : "Send OTP", color: Constants.Colors.bluecolor)
            }
        }.opacity(showAlert || alert ?  0.5 : 1.0).disabled(showAlert || alert)
              
                Spacer()
                if showAlert {
                    if !vm.otpSended {
                        HStack {
                            Text("Fail to sent OTP")
                            Spacer()
                            Button {
                                showAlert.toggle()
                            }label: {
                                Image(systemName: Constants.Icons.cross)
                            }
                        }.padding().background(.red).cornerRadius(10).foregroundColor(.white).padding()
                    }
                }
                if alert {
                    CustomAlert(text: vm.otpSended ? "Passcode is empty" : Constants.Alert.invalidPhone, dismiss: $alert)
                }
        }.onTapGesture {
            hideKeyboard()
        }.alert(isPresented: $vm.phoneOTPVerified, content: {
            Alert(title: Text("Success"), message: Text("Phone number has been verified"), dismissButton: .cancel(Text("Okay"),action: {
                vm.apiCall(forMethod: .getUser)
                dismiss()
            }))
        })
            .padding()
        
    }
}

struct PhoneView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PhoneView().environmentObject(LoginSignUpViewModel())
        }
    }
}
