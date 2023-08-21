//
//  ChangePasswordView.swift
//  BlaBalApp
//
//  Created by ChicMic on 31/05/23.
//

import SwiftUI

struct ChangePasswordView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var networkStatusManager: NetworkStatusManager
    @State var showPassword = false
    @EnvironmentObject var vm: LoginSignUpViewModel
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
             
                CustomTextfield(label: Constants.Labels.oldPassword, placeholder: Constants.Placeholders.oldPassword, value: $vm.oldPassword)
                CustomTextfield(label: Constants.Labels.NewPassword, placeholder: Constants.Placeholders.NewPassword, value: $vm.newPassword)
                VStack(alignment: .leading) {
                    Text("Confirm new password")
                    HStack {
                        if showPassword {
                            TextField(Constants.Placeholders.passwordplc, text: $vm.confirmNewPassword)  .textInputAutocapitalization(.never).padding()
                        } else {
                            SecureField(Constants.Placeholders.passwordplc, text: $vm.confirmNewPassword)  .textInputAutocapitalization(.never).padding()
                        }
                        Button {
                            showPassword.toggle()
                        } label: {
                            Image(systemName: showPassword ? Constants.Icons.eye : Constants.Icons.eyeSlash)
                                .foregroundColor(.gray)
                                .padding(.trailing, 20)
                                .frame(width: 30)
                        }
                    }
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .onAppear {
                        showPassword = false
                    }

                }
               Spacer()
                Button {
                    vm.apiCall(forMethod: .changePassword )
                    vm.isLoading = true
                    // change password api
                } label: {
                    Buttons(image: "", text: Constants.Buttons.save, color: Constants.Colors.bluecolor).padding(.vertical)
                    
                }.alert(isPresented: $vm.passwordChangeSuccessAlert) {
                    Alert(
                        title: Text(Constants.Alert.success),
                        message: Text(SuccessAlerts.changePassword.rawValue),
                        dismissButton: .cancel(Text(Constants.Buttons.ok), action: {
                            dismiss()
                        })
                    )
                }
            }.padding()
                .alert(isPresented: $vm.passwordChangeFailAlert) {
                    Alert(
                        title: Text(Constants.Alert.error),
                        message: Text(ErrorAlert.changePassword.rawValue),
                        dismissButton: .cancel(Text(Constants.Buttons.ok))
                    )
                }

        }.navigationTitle(Text(Constants.Header.changePassword)).overlay(content: {
            if vm.isLoading {
                ProgressView().progressViewStyle(.circular)
            }
        }).onTapGesture {
            hideKeyboard()
        }.onAppear {
            vm.passwordChangeSuccessAlert = false
        }
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView().environmentObject(LoginSignUpViewModel())
    }
}
