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
                CustomTextfield(label: "Old password", placeholder: "Old password", value: $vm.oldPassword)
                CustomTextfield(label: "New password", placeholder: "New password", value: $vm.newPassword)
                CustomTextfield(label: "Confirm new password", placeholder: "Confirm new password", value: $vm.confirmNewPassword)
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
                        title: Text(Constants.Alert.error),
                        message: Text(vm.response?.status.error ?? "Unknown Error"),
                        dismissButton: .cancel(Text(Constants.Buttons.ok))
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
