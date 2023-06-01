//
//  DistanceCircleShowView.swift
//  BlaBalApp
//
//  Created by ChicMic on 26/05/23.
//

import SwiftUI

struct DistanceCircleShowView: View {
    @State var distance: Double = 50
    var height: CGFloat
    var body: some View {
        VStack {
//            Image(systemName: "circlebadge").bold()
            ProgressView( value: 100, total: 100).rotationEffect(Angle(degrees: 90)).frame(maxHeight: .infinity)
        }
    }
}

struct DistanceCircleShowView_Previews: PreviewProvider {
    static var previews: some View {
        DistanceCircleShowView(height: 355.21)
    }
}
