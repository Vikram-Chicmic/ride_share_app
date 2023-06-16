//
//  RideDetailTileView.swift
//  BlaBalApp
//
//  Created by ChicMic on 12/06/23.
//

import SwiftUI

struct RideDetailTileView: View {
    var title: String
    var value: String
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value).foregroundColor(.gray)
        }
    }
}

struct RideDetailTileView_Previews: PreviewProvider {
    static var previews: some View {
        RideDetailTileView(title: "Departure time", value: "Sat, Jan 01, 4:11 PM")
    }
}
