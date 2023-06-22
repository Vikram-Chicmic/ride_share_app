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
        NavigationStack {
            VStack {
                BackgroundView().padding(.top, -20)
                Spacer()
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
                        HollowButton(image: "", text: Constants.Buttons.login, color: Constants.Colors.bluecolor)
                       
                    }
                    .accentColor(Color(red: 0.993, green: 0.452, blue: 0.366))
                }.padding(.top, 30)

            }.onAppear {
                isLoginView = false
                
            }
                .padding()
                .navigationDestination(isPresented: $navigate) {
                    LoginSignupWithEmailView(isLoginView: $isLoginView)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
