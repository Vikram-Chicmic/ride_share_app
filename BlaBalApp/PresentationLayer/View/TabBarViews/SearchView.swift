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
                VStack{
                    Spacer()
                    Image("carPOOl").resizable().ignoresSafeArea().scaledToFit().opacity(0.8)
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
