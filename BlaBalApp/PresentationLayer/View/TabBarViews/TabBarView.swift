//
//  TabBarView.swift
//  BlaBalApp
//
//  Created by ChicMic on 11/05/23.
//

import SwiftUI

struct TabBarView: View {
    @State var showPublishView = false
    @EnvironmentObject var vm: LoginSignUpViewModel
  
    var body: some View {
            TabView {
                SearchView()
                    .tabItem {
                        Label(Constants.Labels.search, systemImage: Constants.Icons.quotes)
                }
                YourRidesView().tabItem {
                    Label(Constants.Labels.ride, systemImage: Constants.Icons.car)
                }
                InboxView().tabItem {
                    Label(Constants.Labels.inbox, systemImage: Constants.Icons.bubble)
                }
                ProfileView(vm: vm).tabItem {
                  Label(Constants.Labels.person, systemImage: Constants.Icons.perosn)
                }
                
                
            }.background(content: {
                Color.black
            }).navigationBarBackButtonHidden(true)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView().environmentObject(LoginSignUpViewModel())
    }
}
