//
//  SearchView.swift
//  BlaBalApp
//
//  Created by ChicMic on 10/05/23.
//

import SwiftUI

struct SearchView: View {
    @State var isPublishView = false
    @State var showAlert = false
    @EnvironmentObject var networkStatusManager: NetworkStatusManager
    @EnvironmentObject var vm: MapAndRidesViewModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("carpoolIcon").resizable().frame(width: 50, height: 50).scaledToFit()
                Text("Car Pool").font(.title2).fontWeight(.semibold).padding(.leading)
                Spacer()
            }.padding(.horizontal)
            
                    Rectangle().frame(height: 3).foregroundColor(.gray.opacity(0.2))
            ScrollView {
                LocationView(isPublishView: $isPublishView, isComingFromPublishedView: .constant(false), showAlert: $showAlert)
                Spacer()
            }.disabled(showAlert ? true : false).opacity(showAlert ? 0.5 : 1)
        }.overlay(alignment: .bottom, content: {
            if showAlert {
                if isPublishView {
                    CustomAlert(text: Int(vm.amount) ?? 0 < 1 ?
                                RegisterVehicleViewModel.shared.decodedVehicleData?.data.count == 0 || MapAndRidesViewModel.shared.vehicleId == 0 ?
                                "No vehicle found" :
                                    "Invalid amount" :
                                    Constants.Alert.emptyfield, dismiss: $showAlert)
                } else {
                    CustomAlert(text: Constants.Alert.emptyfield, dismiss: $showAlert)
                }
            }
        })
            .onTapGesture {
                self.hideKeyboard()
            }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
