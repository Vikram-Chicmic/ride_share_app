//
//  DistanceCircleShowView.swift
//  BlaBalApp
//
//  Created by ChicMic on 26/05/23.
//

import SwiftUI

struct DistanceCircleShowView: View {
    var maxWidhth: CGFloat
    var maxHeight: CGFloat
    var body: some View {
        VStack {
            Image(systemName: Constants.Icons.circle).foregroundColor(.cyan).font(.subheadline).bold()
            Capsule().fill(Color.white).frame(maxWidth: maxWidhth, maxHeight: maxHeight)
            Image(systemName: Constants.Icons.circle).foregroundColor(.cyan).font(.subheadline).bold()
        }
    }
}

struct DistanceCircleShowView_Previews: PreviewProvider {
    static var previews: some View {
        DistanceCircleShowView(maxWidhth: 2, maxHeight: 35)
    }
}
