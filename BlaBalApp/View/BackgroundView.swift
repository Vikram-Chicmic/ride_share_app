//
//  BackgroundView.swift
//  BlaBalApp
//
//  Created by ChicMic on 10/05/23.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        VStack {
            Image(Constants.Icons.bgImage).resizable().scaledToFill().ignoresSafeArea().frame(height: 450).padding(.top, -20)
        }.background(.white)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
