//
//  ForgotPasswordView.swift
//  BlaBalApp
//
//  Created by ChicMic on 17/08/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State var email: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            Text("")
            CustomTextfield(label: "", placeholder: "Enter your email", value: $email).padding()
            Spacer()
        }
    }
    
 
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
