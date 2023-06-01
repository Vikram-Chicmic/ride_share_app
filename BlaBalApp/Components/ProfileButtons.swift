//
//  ProfileButtons.swift
//  BlaBalApp
//
//  Created by ChicMic on 12/05/23.
//

import SwiftUI

struct ProfileButtons: View {
    var text: String
    var body: some View {
        HStack {
            Image(systemName: Constants.Icons.pluscircle).font(.title2)
            Text(text).font(.system(size: 20))
        }.foregroundColor(Constants.Colors.bluecolor)
    }
}

struct ProfileButtons_Previews: PreviewProvider {
    static var previews: some View {
        ProfileButtons(text: "Verify my ID")
    }
}
