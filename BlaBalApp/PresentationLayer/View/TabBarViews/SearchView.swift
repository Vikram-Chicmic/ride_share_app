//
//  SearchView.swift
//  BlaBalApp
//
//  Created by ChicMic on 10/05/23.
//

import SwiftUI

struct SearchView: View {
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                VStack {
                    BackgroundView().frame(height: 250)
                    Spacer()
                    Image(Constants.Images.image).resizable().scaledToFit().padding(.bottom).opacity(0.7)
                }.background(.white)
                VStack {
                    LocationView().frame(width: 350)
                    Spacer()
                    
                }.padding(.top, 80)
                
                
            }.onTapGesture {
                self.hideKeyboard()
            }

        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView().environmentObject(MapAndSearchRideViewModel())
    }
}
