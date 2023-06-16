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
            Image(Constants.Icons.bgImage).resizable().ignoresSafeArea().frame(width: 450, height: 350)
            Spacer()
        }.background(.white)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
