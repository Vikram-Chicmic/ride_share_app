//
//  LoginSignupView.swift
//  BlaBalApp
//
//  Created by ChicMic on 10/05/23.
//

import SwiftUI

struct LoginSignupWithEmailView: View {
    @EnvironmentObject var vm: LoginSignUpViewModel
    @State var showPassword = true
    @State var isPopoverShowing = false
    @Binding var isLoginView: Bool
    @State var navigate: Bool = false
    @State var navigateToForgot = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var networkStatusManager: NetworkStatusManager
    var body: some View {
        ZStack {
            
            VStack(spacing: 10) {
                Spacer()
                Text(isLoginView ? Constants.Header.login : Constants.Header.signup).foregroundColor(Constants.Colors.bluecolor).font(.largeTitle).fontWeight(.semibold).padding(.bottom, 50)

                VStack {
                    CustomTextfield(label: Constants.Labels.email, placeholder: Constants.Placeholders.emailplc, value: $vm.email).textInputAutocapitalization(.never).keyboardType(.emailAddress).autocorrectionDisabled(true)
                }.padding(.bottom).overlay(alignment: .bottomTrailing) {
                             if !vm.email.isEmpty && !isLoginView {
                                 HStack {
                                     Spacer()
                                     Image(systemName: !vm.isUserEmailValid ? "exclamationmark.triangle.fill" : "checkmark.circle.fill" )
                                        .font(.subheadline)
                                        .foregroundColor(vm.isUserEmailValid ? .green : .red)
                                        
                                     
                                 }.padding(.bottom, -5)     // Add an animation
                             }
                         
                }
                VStack {
                    HStack {
                        Text(Constants.Labels.password)
                        if !vm.isUserPasswordValid {
                            Button(action: {
                                isPopoverShowing.toggle()
                            }, label: {
                                Image(systemName: Constants.Icons.questionMark)
                                    .foregroundColor(.blue)
                            }).alert(isPresented: $isPopoverShowing) {
                                Alert(title: Text(Constants.Labels.help),
                                      message: Text(Constants.Alert.passwordDiscription),
                                      dismissButton: .cancel(Text(Constants.Labels.ok))
                                )
                            }
                        }
                        Spacer()
                    }
                    HStack {
                        if showPassword {
                            TextField(Constants.Placeholders.passwordplc, text: $vm.password)  .textInputAutocapitalization(.never).padding().autocorrectionDisabled(true)
                                .frame(height: 50)
                        } else {
                            SecureField(Constants.Placeholders.passwordplc, text: $vm.password)  .textInputAutocapitalization(.never).padding()
                                .frame(height: 50)
                        }
                        Button {
                            showPassword.toggle()
                        } label: {
                            Image(systemName: showPassword ? Constants.Icons.eye : Constants.Icons.eyeSlash)
                                .foregroundColor(.gray)
                                .padding(.trailing, 20)
                                .frame(width: 30, height: 30)
                        }
                    }
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .onAppear {
                        // Ensure that the password is hidden by default
                        showPassword = false
                    }.padding(.bottom).overlay(alignment: .bottomTrailing) {
                        if !vm.password.isEmpty && !isLoginView  {
                            HStack {
                                Spacer()
                                Image(systemName: !vm.isUserPasswordValid ? "exclamationmark.triangle.fill" : "" )
                                   .font(.subheadline)
                                   .foregroundColor(vm.isUserPasswordValid ? .green : .red)
                                   
                                
                            }.padding(.bottom,-5)     // Add an animation
                        }
           }
                }.padding(.bottom)
                
                // MARK: - Button
                Button {
                    if isLoginView {
//                        vm.login()
                        vm.apiCall(forMethod: .login)
                    } else {
                        vm.apiCall(forMethod: .checkEmail)
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text(isLoginView ? Constants.Buttons.login : Constants.Buttons.signup)
                            .frame(height: 50)
                        Spacer()
                    }.foregroundColor(.white)
                        .background(
                             isLoginView ?
                                LinearGradient(colors: [Constants.Colors.bluecolor, .blue], startPoint: .leading, endPoint: .trailing)
                                :
                                vm.formIsValid ?
                                LinearGradient(colors: [Constants.Colors.bluecolor, .blue], startPoint: .leading, endPoint: .trailing) :
                                    LinearGradient(colors: [.gray, Color(red: 0.375, green: 0.342, blue: 0.342)], startPoint: .leading, endPoint: .trailing)
                            
                           
                        ).cornerRadius(10)
                }.navigationDestination(isPresented: $vm.navigate, destination: {
                    TabBarView()
                })
                .alert(isPresented: $vm.showAlert) {
                    Alert(title: Text(Constants.Alert.error), message: Text(isLoginView ? Constants.Alert.userNotExist : Constants.Alert.usrExist), dismissButton: .default(Text(Constants.Buttons.ok)))
                }
                .disabled(!vm.formIsValid && !isLoginView)
                
                if isLoginView {
                    Button {
                        navigateToForgot.toggle()
                    } label: {
                        Text("forgot password?").font(.subheadline)
                    }.padding(.top).navigationDestination(isPresented: $navigateToForgot) {
                        ForgotPasswordView()
                    }
                }
                
                Spacer()
                Spacer()
            }.onTapGesture {
                self.hideKeyboard()
            }.opacity(vm.isLoading ? 0.5 : 1.0)
            if vm.isLoading {
                         ProgressView()
                             .progressViewStyle(CircularProgressViewStyle())
                     }
        }.environmentObject(vm)
            .onAppear {
                vm.navigateToForm = false
                showPassword = false
                vm.password = ""
                vm.email = ""
            }
            .padding()
            .navigationDestination(isPresented: $vm.navigateToForm, destination: {
                FormView()
        })
    }
}

struct LoginSignupView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSignupWithEmailView(isLoginView: .constant(false)).environmentObject(LoginSignUpViewModel())
    }
}
