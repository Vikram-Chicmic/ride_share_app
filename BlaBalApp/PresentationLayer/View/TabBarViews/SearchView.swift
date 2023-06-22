//
//  SearchView.swift
//  BlaBalApp
//
//  Created by ChicMic on 10/05/23.
//

import SwiftUI

struct SearchView: View {
    @State var isPublishView = true
    var body: some View {
                VStack {
                    LocationView(isPublishView: $isPublishView, isComingFromPublishedView: .constant(false))
                    Spacer()
                }
            .background {
                VStack {
                    Spacer()
                    Image(Constants.Images.image).resizable().scaledToFit().padding(.bottom).opacity(0.5)
                }
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
