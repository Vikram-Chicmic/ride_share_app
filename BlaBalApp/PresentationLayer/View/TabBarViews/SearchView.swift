//
//  SearchView.swift
//  BlaBalApp
//
//  Created by ChicMic on 10/05/23.
//

import SwiftUI

struct SearchView: View {
    @State var isPublishView = false
    var body: some View {
                VStack {
                    LocationView(isPublishView: $isPublishView, isComingFromPublishedView: .constant(false))
                    Spacer()
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
