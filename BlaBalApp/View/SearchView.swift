//
//  SearchView.swift
//  BlaBalApp
//
//  Created by ChicMic on 10/05/23.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        ZStack {
            VStack {
                BackgroundView().frame(height: 250)
                Spacer()
            }.background(.white)
            LocationView().frame(width: 350)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
