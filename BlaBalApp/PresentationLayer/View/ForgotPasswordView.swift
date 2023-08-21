//
//  ForgotPasswordView.swift
//  BlaBalApp
//
//  Created by ChicMic on 17/08/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    @EnvironmentObject var vm: LoginSignUpViewModel
    @State var otp: String = ""
    @State private var countdown = 30
    @State private var isButtonDisabled = false
    @State private var timer: Timer?
    @State var navigate = false
    @State var success = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var networkStatusManager: NetworkStatusManager
    var body: some View {
        VStack {
            VStack {
                Image(systemName: vm.alertOtpSendSucces ? "envelope.circle" : "key.radiowaves.forward.fill")
                    .foregroundColor(Constants.Colors.bluecolor)
                    .font(.title)
                Text(vm.alertOtpSendSucces ? "Check your email" : "Forgot password?")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom, 5)
                Text(vm.alertOtpSendSucces ? "We have sent a password reset otp to " : "No worries, we'll send you reset instructions.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                if vm.alertOtpSendSucces {
                    Text("\(vm.email)")
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                        .font(.subheadline)
                }
            }.padding(.top)
            
            VStack {
                VStack(alignment: .leading) {
                 
            
                    if vm.alertOtpSendSucces {
                        CustomTextfield(label: "", placeholder: "Enter 4 digit OTP", value:  Binding(
                            get: { otp },
                            set: { newValue in
                                let truncatedValue = String(newValue.prefix(4))
                                otp = truncatedValue
                            }
                        ))
                            .keyboardType(.numberPad)
                    } else {
                        CustomTextfield(label: "", placeholder: "Enter your email", value: $vm.email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                    }
                }
                
                Button {
                    vm.isLoading = true
                    if vm.alertOtpSendSucces {
                        vm.emailOTP = Int(otp) ?? 0
                        vm.apiCall(forMethod: .verifyEmailOtp)
                    } else {
                        vm.apiCall(forMethod: .forgotPassword)
                        startTimer()
                        isButtonDisabled = true
                    }
                } label: {
                    Buttons(image: "", text: vm.alertOtpSendSucces ? "Verify OTP" : "Send OTP", color: Constants.Colors.bluecolor)
                }.navigationDestination(isPresented: $vm.emailOtpVerified) {
                    PasswordResetView(successfull: $success)
                }
                
                if vm.alertOtpSendSucces {
                        Button {
                            withAnimation {
                                vm.alertOtpSendSucces = false
                            }
                        } label: {
                            Text("Change email?")
                        }.padding(.top)
                        
                        Spacer()
                        HStack {
                            Text("Didn't recieve the email?").foregroundColor(.gray).font(.subheadline)
                            Button {
                                vm.apiCall(forMethod: .forgotPassword)
                                isButtonDisabled = true
                                startTimer()
                            } label: {
                            
                                
                                VStack {
                                    if isButtonDisabled {
                                        Text("00: \(countdown)")
                                            .font(.subheadline)
                                    } else {
                                        Text("Resend otp")
                                    }
                                }.frame(width: 100)
                            }
                            .disabled(isButtonDisabled)
                        }
                      
                    
                }
               
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Text("Back to login")
                    }.font(.subheadline)
                }
                
               
            }
            .padding()
        }.onTapGesture {
            hideKeyboard()
        }
        .alert(isPresented: $vm.failtToSendOtpAlertForEmail, content: {
            Alert(title: Text("Error"), message: Text(vm.responseForForgotPassword?.error ?? "Invalid OTP or Email. Please Check and try again."), dismissButton: .cancel(Text("Okay")))
        })
        .onAppear {
            if success {
                dismiss()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onDisappear {
            vm.alertOtpSendSucces = false
        }
        .disabled(vm.isLoading)
        .opacity(vm.isLoading ? 0.5 : 1.0)
        .overlay {
            if vm.isLoading {
                ProgressView().progressViewStyle(CircularProgressViewStyle())
            }
        }
    }
    
    func startTimer() {
        isButtonDisabled = true
        countdown = 30
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            countdown -= 1
            if countdown <= 0 {
                timer.invalidate()
                isButtonDisabled = false
            }
        }
        timer?.fire()
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        isButtonDisabled = false
        countdown = 30
    }
}
