//
//  HollowButton.swift
//  BlaBalApp
//
//  Created by ChicMic on 22/06/23.
//

import SwiftUI

struct HollowButton: View {

        var image: String
        var text: String
        var color: Color
        var body: some View {
            HStack {
                Spacer()
                Image(systemName: image).font(.title2)
                Text(text).frame(height: 50)
                Spacer()
            } .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(color, lineWidth: 2)
            )
            .contentShape(RoundedRectangle(cornerRadius: 25)).foregroundColor(color).fontWeight(.semibold)
        }
       
}

struct HollowButton_Previews: PreviewProvider {
    static var previews: some View {
        HollowButton(image: "", text: "Edit", color: Constants.Colors.bluecolor)
    }
}
