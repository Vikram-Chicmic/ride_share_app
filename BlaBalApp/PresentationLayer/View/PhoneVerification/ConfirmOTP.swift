//
//  ConfirmOTP.swift
//  BlaBalApp
//
//  Created by ChicMic on 31/05/23.
//

import SwiftUI

struct ConfirmOTPView: View {
    var textboxColor = Color(red: 235/255, green: 235/255, blue: 235/255)
    var selectedColor = Color(red: 122/255, green: 177/255, blue: 253/255)
    @ObservedObject var vmm: LoginSignUpViewModel
    @State var isSelected: Bool = false
    @Binding var showview: Bool
    @State var otp1 = ""
    var body: some View {
        VStack {
            Text(Constants.Header.confirmPasscode).foregroundColor(.black).padding().font(.title2).fontWeight(.semibold)
                Spacer()
            TextField("", text: Binding(
                get: { vmm.passcode },
                set: { newValue in
                    let truncatedValue = String(newValue.prefix(4))
                    vmm.passcode = truncatedValue
                }
            )).frame(width: 220, height: 50).background(.gray.opacity(0.3)).font(.title2).cornerRadius(10).foregroundColor(.black).multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            
            Button {
                vmm.sendOTP = false
                vmm.apiCall(forMethod: .otpVerify)
                if vmm.phoneVerified {
                    showview.toggle()
                } else {
                    //Alert("Cant varify")
                }
            } label: {
                Buttons(image: "", text: Constants.Texts.confirm, color: vmm.passcode.count != 4 ? .gray : Constants.Colors.bluecolor).frame(width: 220).padding(.top, 20)
            }.disabled(vmm.passcode.count != 4)
            Button {
                showview.toggle()
            } label: {
                Text(Constants.Buttons.back).frame(height: 50)
            }
            Spacer()
        }.onAppear {
            vmm.passcode = ""
        }
        .frame(width: 300, height: 300).background(Color.white).cornerRadius(25).shadow(color: .gray, radius: 40)
    }
}

struct ConfirmOTP_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmOTPView( vmm: LoginSignUpViewModel(), showview: .constant(true))
    }
}
