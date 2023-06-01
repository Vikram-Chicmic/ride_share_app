//
//  BlaBalAppApp.swift
//  BlaBalApp
//
//  Created by ChicMic on 10/05/23.
//

import SwiftUI

@main
struct BlaBalAppApp: App {
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

//            LandingView().environmentObject(vm)
        }
    }
}
