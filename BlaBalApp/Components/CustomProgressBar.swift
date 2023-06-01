//
//  CustomProgressBar.swift
//  BlaBalApp
//
//  Created by ChicMic on 22/05/23.
//

import SwiftUI

struct CustomProgressBar: View {
    @Binding var step: Int
    var body: some View {
        ZStack(alignment: .leading) {
            Image(Constants.Images.road).resizable().frame(height: 3).padding(.top, 21)
            HStack {
                Image(Constants.Images.car).resizable().frame(width: 100, height: 90).padding(.leading, 85*CGFloat(step))
            }
            HStack {
                Spacer()
                Image(Constants.Images.dest).resizable().frame(width: 40, height: 75).padding(.bottom, 40)
            }
        }.frame(width: 360, height: 100)
    }
}

struct CustomProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressBar(step: .constant(1))
    }
}
