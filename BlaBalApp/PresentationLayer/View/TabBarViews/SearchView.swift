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
    var body: some View {
                VStack {
                    LocationView(isPublishView: $isPublishView, isComingFromPublishedView: .constant(false), showAlert: $showAlert)
                    Spacer()
                    if showAlert {
                        CustomAlert(text: Constants.Alert.emptyfield, dismiss:$showAlert)
                    }
                }.onAppear {
//                    Helper().emptyMapAndSearchView()
                }
            .background {
               
            }.onTapGesture {
                self.hideKeyboard()
            }

        

    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView().environmentObject(MapAndSearchRideViewModel())
    }
}
