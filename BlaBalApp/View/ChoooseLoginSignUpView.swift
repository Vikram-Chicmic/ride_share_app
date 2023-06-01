//
//  LoginAndSignUpView.swift
//  BlaBalApp
//
//  Created by ChicMic on 10/05/23.
//

import SwiftUI

struct LoginAndSignUpView: View {
    @Binding var isLoginView: Bool
    @Environment(\.dismiss) var dismiss
    @State var navigateToLogin = false
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                dismiss()
            } label: {
                Image(systemName: Constants.Icons.cross).padding().font(.title2).foregroundColor(Constants.Colors.bluecolor)
            }
            Text(isLoginView ? Constants.Texts.login : Constants.Texts.signup).font(.largeTitle).fontWeight(.semibold).frame(width: 300).padding(.bottom)
            // MARK: - Buttons
            Group {
                Button {
                    navigateToLogin.toggle()
                } label: {
                    Buttons(image: Constants.Icons.mail, text: Constants.Buttons.email, color: Constants.Colors.bluecolor).padding()
                }
            }
            Text(isLoginView ? Constants.Texts.notamember : Constants.Texts.haveaccount).font(.title2).fontWeight(.semibold).padding()
            Button {
                withAnimation {
                    isLoginView.toggle()
                }
            }label: {
                Text(isLoginView ? Constants.Buttons.signup : Constants.Buttons.login).padding(.horizontal).font(.title3).fontWeight(.semibold)
            }
            Spacer()
        }.sheet(isPresented: $navigateToLogin, content: {
            LoginSignupWithEmailView(isLoginView: $isLoginView)
        }).onDisappear {
            isLoginView = false
        }
    }
}

struct LoginAndSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        LoginAndSignUpView(isLoginView: .constant(false))
    }
}
