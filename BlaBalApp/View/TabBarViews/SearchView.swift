//
//  SearchView.swift
//  BlaBalApp
//
//  Created by ChicMic on 10/05/23.
//

import SwiftUI

struct SearchView: View {
    
    var body: some View {
        ZStack(alignment: .top){
            VStack {
                BackgroundView().frame(height: 250)
                Spacer()
                Image("Image").resizable().scaledToFit().padding(.bottom).opacity(0.7)
            }.background(.white)
            VStack {
                LocationView().frame(width: 350)
                Spacer()
                
            }.padding(.top, 80)
            
            
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView().environmentObject(MapAndSearchRideViewModel())
    }
}
