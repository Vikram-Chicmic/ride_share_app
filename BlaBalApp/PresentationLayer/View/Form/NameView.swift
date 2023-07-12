//
//  NameView.swift
//  BlaBalApp
//
//  Created by ChicMic on 12/05/23.
//

import SwiftUI

struct NameView: View {
    @EnvironmentObject var vm: LoginSignUpViewModel
    @State var navigate: Bool = false
    @Binding var alert: Bool
    var body: some View {
        
            ZStack {
                ScrollView {
                    VStack(alignment: .leading) {
                                Text(Constants.Titles.name).font(.title).fontWeight(.semibold).padding(.vertical)
                            CustomTextfield(label: Constants.Labels.fname, placeholder: Constants.Placeholders.fname, value: Binding(
                                get: { vm.fname },
                                set: { newValue in
                                    let truncatedValue = String(newValue.prefix(30))
                                    vm.fname = truncatedValue
                                }
                            ) )
                                .textInputAutocapitalization(.words)
                                .autocorrectionDisabled(true)
                            
                                CustomTextfield(label: Constants.Labels.lname, placeholder: Constants.Placeholders.lname, value: $vm.lname).autocapitalization(.words)
                            
                            Text("Name should not contain any special character, number and spaces.Maximum name length is 50").font(.subheadline).foregroundColor(.gray).padding(.top)
                                Spacer()
                    
                                if alert {
                                    CustomAlert(text: Constants.Alert.invalidname, dismiss: $alert)
                                   }
                    }
                }

            }.onTapGesture {
                self.hideKeyboard()
            }.onAppear {
            }
            .padding(.horizontal)
        
        }
}

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView(alert: .constant(false)).environmentObject(LoginSignUpViewModel())
    }
}
