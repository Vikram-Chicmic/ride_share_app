//
//  TabBarView.swift
//  BlaBalApp
//
//  Created by ChicMic on 11/05/23.
//

import SwiftUI

enum Tabs {
    case searchView
    case yourRideView
    case inboxView
    case profileView
}

struct TabBarView: View {
    @State var showPublishView = false
    @EnvironmentObject var vm: LoginSignUpViewModel
   
    var body: some View {
        
        TabView(selection: $vm.currentState) {
                SearchView()
                    .tabItem {
                        Label(Constants.Labels.search, systemImage: Constants.Icons.quotes)
                }.tag(Tabs.searchView)
            
                YourRidesView().tabItem {
                    Label(Constants.Labels.ride, systemImage: Constants.Icons.car)
                }.tag(Tabs.yourRideView)
            
                InboxView().tabItem {
                    Label(Constants.Labels.inbox, systemImage: Constants.Icons.bubble)
                }.tag(Tabs.inboxView)
            
                ProfileView().tabItem {
                    Label(Constants.Labels.person, systemImage: Constants.Icons.perosn)
                }.tag(Tabs.profileView)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView().environmentObject(LoginSignUpViewModel())
    }
}
