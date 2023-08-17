//
//  SplashScreen.swift
//  BlaBalApp
//
//  Created by ChicMic on 14/07/23.
//

import SwiftUI

struct SplashScreen: View {
    @StateObject var navigationVm = NavigationViewModel.shared
    @State var loginStatus: Bool = true
   
    var body: some View {
        NavigationStack(path: $navigationVm.paths) {
            VStack {
                Image("carpoolIcon")
                    .resizable()
                    .frame(width: 90, height: 90)
                Text("Ride Share").font(.title).fontWeight(.semibold)
            }.navigationBarBackButtonHidden(true)
            .onAppear {
                loginStatus = UserDefaults.standard.bool(forKey: Constants.Url.userLoggedIN)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    navigationVm.push(loginStatus ? .tabView : .landingView)
                }
            }
            .navigationDestination(for: ViewIdentifiers.self) { path in
                switch path {
                case .landingView: LandingView()
                case .tabView: TabBarView()
                }
            }
        }
    }
}


struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen(loginStatus: true)
    }
}
