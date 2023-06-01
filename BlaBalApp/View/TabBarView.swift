//
//  TabBarView.swift
//  BlaBalApp
//
//  Created by ChicMic on 11/05/23.
//

import SwiftUI

struct TabBarView: View {
    @State var showPublishView = false
    @ObservedObject var vm: LoginSignUpViewModel
    var body: some View {
        NavigationStack {
            TabView {
                SearchView()
                    .tabItem {
                        Label(Constants.Labels.search, systemImage: Constants.Icons.magnifyingGlass)
                }
              
                Group {
                    Text("").tabItem {
                        Label(Constants.Labels.publish, systemImage: Constants.Icons.pluscircle )
                    }.onTapGesture {
                        showPublishView = true
                    }
                }.sheet(isPresented: $showPublishView) {
                   PublishView()
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
                
                
            }.navigationBarBackButtonHidden(true)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(vm: LoginSignUpViewModel())
    }
}
