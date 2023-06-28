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
    @StateObject var vm = LoginSignUpViewModel.shared
    @StateObject var vehicleVm = RegisterVehicleViewModel.shared
    @StateObject var mapVm = MapAndSearchRideViewModel.shared
    @StateObject var sessionManager = SessionManager()
    @StateObject var baseAPiManager = BaseApiManager.shared
    var body: some Scene {
        WindowGroup {
            Group {
                if vm.userLoggedIn {
                    NavigationStack {
                        TabBarView()
                    }
                } else {
                    NavigationStack {
                        LandingView()
                    }
                }
            }.environmentObject(vm)
                .environmentObject(vehicleVm)
                .environmentObject(mapVm)
                .environmentObject(sessionManager)
                .environmentObject(baseAPiManager)
            }
             
            
        }
    }

