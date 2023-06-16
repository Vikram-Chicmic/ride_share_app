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
                    VStack(alignment: .leading) {
                            Text(Constants.Titles.name).font(.title).fontWeight(.semibold).padding(.vertical)
                        CustomTextfield(label: Constants.Labels.fname, placeholder: Constants.Placeholders.fname, value: $vm.fname)
                            CustomTextfield(label: Constants.Labels.lname, placeholder: Constants.Placeholders.lname, value: $vm.lname)
                            Spacer()
                
                            if alert {
                                CustomAlert(text: Constants.Alert.emptyfield, dismiss: $alert)
                               }
                        }

            }.onAppear {
                vm.fname = ""
                vm.lname = ""
            }
            .padding(.horizontal)
        
        }
}

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView(alert: .constant(false)).environmentObject(LoginSignUpViewModel())
    }
}
