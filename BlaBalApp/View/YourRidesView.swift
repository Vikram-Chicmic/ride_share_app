//
//  YourRidesView.swift
//  BlaBalApp
//
//  Created by ChicMic on 11/05/23.
//

import SwiftUI

struct YourRidesView: View {
    var body: some View {
        VStack {
            Image(Constants.Images.travel).resizable().scaledToFit()
            Text(Constants.Header.travel).font(.title).fontWeight(.semibold).padding(.trailing).padding(.vertical)
            Text(Constants.Texts.travel).foregroundColor(.gray).padding(.trailing)
            Spacer()
        }.padding(.horizontal)
    }
}

struct YourRidesView_Previews: PreviewProvider {
    static var previews: some View {
        YourRidesView()
    }
}
