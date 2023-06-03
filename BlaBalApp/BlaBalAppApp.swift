//
//  BlaBalAppApp.swift
//  BlaBalApp
//
//  Created by ChicMic on 10/05/23.
//

import SwiftUI

@main
struct BlaBalAppApp: App {
    init() {
            GoogleMapsProvider.configure()
        }

    @StateObject var vm = LoginSignUpViewModel()
    var body: some Scene {
        WindowGroup {
            Group {
                if vm.userLoggedIn {
                    TabBarView(vm: vm)
                } else {
                    LandingView().environmentObject(vm)
                }
            }
//  Content1View()
//            LandingView().environmentObject(vm)
        }
    }
}
