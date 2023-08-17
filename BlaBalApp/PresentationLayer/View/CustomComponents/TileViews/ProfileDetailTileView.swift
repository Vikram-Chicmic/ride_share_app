//
//  ProfileDetailTileView.swift
//  BlaBalApp
//
//  Created by ChicMic on 13/06/23.
//

import SwiftUI

struct ProfileDetailTileView: View {
    var image: String
    var value: String
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: image).foregroundColor(Constants.Colors.bluecolor).scaledToFit().frame(width: 10)
            Text(value).foregroundColor(.gray)
        }
    }
}

struct ProfileDetailTileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailTileView(image: "phone.fill", value: "9888986110")
    }
}
