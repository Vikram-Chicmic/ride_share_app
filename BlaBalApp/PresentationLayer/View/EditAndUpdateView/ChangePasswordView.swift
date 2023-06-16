//
//  ChangePasswordView.swift
//  BlaBalApp
//
//  Created by ChicMic on 31/05/23.
//

import SwiftUI

struct ChangePasswordView: View {
    @Environment(\.dismiss) var dismiss
    @State var showAlert = false
    @StateObject var vm = UpdateUserViewModel()
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: Constants.Icons.cross).padding().font(.title2).foregroundColor(Constants.Colors.bluecolor)
                }
                Spacer()
                Text(Constants.Header.changePassword).font(.title2).fontWeight(.semibold)
                Spacer()
                Spacer()
            }.padding(.bottom)
            VStack {
                CustomTextfield(label: Constants.Labels.oldPassword, placeholder: Constants.Placeholders.oldPassword, value: $vm.oldPassword)
                CustomTextfield(label: Constants.Labels.NewPassword, placeholder: Constants.Placeholders.NewPassword, value: $vm.newPassword)
                CustomTextfield(label: Constants.Labels.ConfirmNewPassword, placeholder: Constants.Placeholders.ConfirmNewPassword, value: $vm.confirmNewPassword)
               Spacer()
                Button {
                    vm.updatePassword()
                    if vm.success {
                        dismiss()
                    } else {
                        showAlert.toggle()
                    }
                    // change password api
                } label: {
                    Buttons(image: "", text: Constants.Buttons.save, color: Constants.Colors.bluecolor).padding(.vertical)
                    
                }.alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(Constants.Alert.success),
                        message: Text(vm.response?.status.message ?? ""),
                        dismissButton: .cancel(Text(Constants.Buttons.ok), action: {
                            dismiss()
                        })
                    )
                }
            }.padding(.horizontal)
        }.onAppear {
            vm.success = false
        }
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
