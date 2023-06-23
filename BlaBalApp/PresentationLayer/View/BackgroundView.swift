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
            Spacer()
            Image("carPool2").resizable().scaledToFit()
            Spacer()
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
