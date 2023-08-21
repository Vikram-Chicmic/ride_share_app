//
//  PasswordResetView.swift
//  BlaBalApp
//
//  Created by ChicMic on 18/08/23.
//

import SwiftUI

struct PasswordResetView: View {
    @State var newPassword = ""
    @State var confirmPassword = ""
    @State var showPassword = false
    @State var showConfirmPassword = false
    @Binding var successfull: Bool
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: LoginSignUpViewModel
    @EnvironmentObject var networkStatusManager: NetworkStatusManager
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "key.radiowaves.forward.fill")
                    .foregroundColor(Constants.Colors.bluecolor)
                    .font(.title)
                Text("Set new password").font(.title).fontWeight(.semibold)
                Text("Create a new strong password").font(.subheadline).foregroundColor(.gray)
            }.padding(.vertical)
            
            
            HStack {
                if showPassword {
                    TextField(Constants.Placeholders.passwordplc, text: $vm.newPassword)  .textInputAutocapitalization(.never).padding().autocorrectionDisabled(true)
                        .frame(height: 50)
                } else {
                    SecureField(Constants.Placeholders.passwordplc, text: $vm.newPassword)
                        .autocorrectionDisabled(true).textInputAutocapitalization(.never).padding()
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
            .cornerRadius(24)
            .onAppear {
                // Ensure that the password is hidden by default
                showPassword = false
            }
            HStack {
                if showConfirmPassword {
                    TextField(Constants.Placeholders.passwordplc, text: $vm.confirmNewPassword)  .textInputAutocapitalization(.never).padding().autocorrectionDisabled(true)
                        .frame(height: 50)
                    
                } else {
                    SecureField(Constants.Placeholders.passwordplc, text: $vm.confirmNewPassword)  .textInputAutocapitalization(.never).padding()
                        .autocorrectionDisabled(true)
                        .frame(height: 50)
                }
                Button {
                    showConfirmPassword.toggle()
                } label: {
                    Image(systemName: showConfirmPassword ? Constants.Icons.eye : Constants.Icons.eyeSlash)
                        .foregroundColor(.gray)
                        .padding(.trailing, 20)
                        .frame(width: 30, height: 30)
                }
            }
            .background(Color.gray.opacity(0.2))
            .cornerRadius(24)
            .onAppear {
                // Ensure that the password is hidden by default
                showPassword = false
            }
          
            Button {
                vm.apiCall(forMethod: .resetPassword)
            } label: {
                Buttons(image: "", text: "Reset password", color: Constants.Colors.bluecolor).padding(.vertical)
            }
            
            Button("Back to login") {
                successfull = true
                dismiss()
            }
            Spacer()
            
        }.onTapGesture {
            hideKeyboard()
        }
        .alert(isPresented: $vm.passwordChangeSuccessAlert, content: {
            Alert(title: Text("Success"), message: Text("Password reset successfully.Please Login"), dismissButton: .cancel(Text("Okay"),action: {
                successfull = true
                dismiss()
            }))
        })
        .alert(isPresented: $vm.passwordChangeFailAlert, content: {
            Alert(title: Text("Success"), message: Text("Fail to reset.Please try agian."), dismissButton: .cancel(Text("Okay")))
        })
        .navigationBarBackButtonHidden(true).padding()
            .onDisappear {
                vm.newPassword = ""
                vm.confirmNewPassword = ""
            }
    }
}

struct PasswordResetView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetView( successfull: .constant(true))
    }
}
