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
    @State var alert: Bool =  false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            VStack {
                    VStack(alignment: .leading) {
                            Text(Constants.Titles.name).font(.title).fontWeight(.semibold).padding(.vertical).padding(.bottom, 40)
                        CustomTextfield(label: Constants.Labels.fname, placeholder: Constants.Placeholders.fname, value: $vm.fname)
                            CustomTextfield(label: Constants.Labels.lname, placeholder: Constants.Placeholders.lname, value: $vm.lname)
                            Spacer()
                            
                            if alert {
                                CustomAlert(text: Constants.Alert.emptyfield, dismiss: $alert)
                               }
                  
                        }
                        .padding()
                    }
            }.padding(.vertical)
        }
}

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView()
    }
}
