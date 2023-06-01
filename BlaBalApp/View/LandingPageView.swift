//
//  ContentView.swift
//  BlaBalApp
//
//  Created by ChicMic on 10/05/23.
//

import SwiftUI

struct LandingView: View {
    @State var navigate: Bool = false
    @State var isLoginView: Bool = false
    var body: some View {
        VStack {
            BackgroundView()
            Text(Constants.Texts.pickride).font(.title).multilineTextAlignment(.center).fontWeight(.semibold).padding()
        VStack {
                Button {
                    navigate.toggle()
                }label: {
                    HStack {
                        Spacer()
                        Text(Constants.Buttons.signup).frame(height: 50)
                        Spacer()
                    }.background(Constants.Colors.bluecolor).cornerRadius(25).foregroundColor(.white).fontWeight(.semibold)
                }
                Button {
                    isLoginView = true
                    navigate.toggle()
                } label: {
                    Text(Constants.Buttons.login).foregroundColor(Constants.Colors.bluecolor).frame(height: 50)
                }
            }.padding(.top, 30)
            Spacer()
        }.onAppear {
            isLoginView = false
        }
            .padding()
            .fullScreenCover(isPresented: $navigate) {
                LoginAndSignUpView(isLoginView: $isLoginView)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
