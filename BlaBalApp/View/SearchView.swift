//
//  SearchView.swift
//  BlaBalApp
//
//  Created by ChicMic on 10/05/23.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var vm: MapAndSearchRideViewModel
    var body: some View {
        ZStack {
            VStack {
                BackgroundView().frame(height: 250)
                Spacer()
            }.background(.white)
            VStack {
                LocationView().frame(width: 350)
            }
            
            
        }.environmentObject(vm)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
