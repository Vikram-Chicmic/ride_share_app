//
//  CarPoolCardSubView.swift
//  BlaBalApp
//
//  Created by ChicMic on 26/05/23.
//

import SwiftUI

struct CarPoolCardSubView: View {
    var place: String
   var location: String
  var distance: String
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(place).bold()
            Text(location).foregroundColor(.gray)
            HStack {
                Image(systemName: "figure.walk")
                Text(distance)
            }.foregroundColor(.green)
        }
    }
}

struct CarPoolCardSubView_Previews: PreviewProvider {
    static var previews: some View {
        CarPoolCardSubView(place: "SOHANA GURUDWARA, Sahibzada Ajit Singh Nagar", location: "Sahibzada Ajit Singh Nagar", distance: "2.5 km from your location")
    }
}
