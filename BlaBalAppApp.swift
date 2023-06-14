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
    @StateObject var vehicleVm = RegisterVehicleViewModel()
    @StateObject var mapVm = MapAndSearchRideViewModel()
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
            }
             
            
        }
    }

