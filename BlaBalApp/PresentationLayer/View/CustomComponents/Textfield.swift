//
//  Textfield.swift
//  BlaBalApp
//
//  Created by ChicMic on 10/05/23.
//

import SwiftUI

struct CustomTextfield: View {
    var label: String
    var placeholder: String
    @Binding var value: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
            HStack {
                TextField(placeholder, text: $value)

            }
                .padding()
                .background(.gray.opacity(0.2))
                .cornerRadius(24)
        }
    }
}

struct CustomTextfield_Previews: PreviewProvider {
    static var previews: some View {

        CustomTextfield(label: Constants.Labels.email, placeholder: Constants.Placeholders.emailplc, value: .constant("heleo"))
    }
}
