//
//  Buttons.swift
//  BlaBalApp
//
//  Created by ChicMic on 10/05/23.
//

import SwiftUI

struct Buttons: View {
    var image: String
    var text: String
    var color: Color
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: image).font(.title2)
            Text(text).frame(height: 50)
            Spacer()
        }.background(color).cornerRadius(25).foregroundColor(.white).fontWeight(.semibold)
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons(image: Constants.Icons.mail, text: Constants.Buttons.signup, color: /*@START_MENU_TOKEN@*/Color(red: 0.563, green: 0.71, blue: 0.974)/*@END_MENU_TOKEN@*/)
    }
}
