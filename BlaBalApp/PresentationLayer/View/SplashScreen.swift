//
//  SplashScreen.swift
//  BlaBalApp
//
//  Created by ChicMic on 14/07/23.
//

import SwiftUI

struct SplashScreen: View {
    @State var animationAmount = 0.9
    @State var navigation = false
    @State var showFirstView = false
    @EnvironmentObject var vm: LoginSignUpViewModel
    @Environment(\.presentationMode) var presentationMode
    var animation: Animation {
        Animation.linear
    }
    var body: some View {
        NavigationStack {
            VStack {
                Image("carpoolIcon")
                    .scaleEffect(animationAmount)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animationAmount)
                    .onAppear {
                        self.animationAmount = 1
                    }
                Text("Ride Share").font(.title).fontWeight(.semibold)
                    .navigationDestination(isPresented: $navigation) {
                    
                        if vm.userLoggedIn {
                            TabBarView()
                        } else {
                            LandingView()
                        }
                    }
            }.onAppear {
                // Simulate a delay before dismissing the splash screen
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    navigation.toggle()
                }
            }
        }.navigationBarBackButtonHidden(true).navigationViewStyle(StackNavigationViewStyle())
            .onChange(of: showFirstView) { newValue in
                if newValue {
                    presentationMode.wrappedValue.dismiss()
                }
            }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
