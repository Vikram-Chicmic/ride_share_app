//
//  PublishView.swift
//  BlaBalApp
//
//  Created by ChicMic on 11/05/23.
//

import SwiftUI

struct PublishView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: Constants.Icons.cross).padding().font(.title2).foregroundColor(Constants.Colors.bluecolor)
            }

            Text(Constants.Header.pick).font(.largeTitle).fontWeight(.semibold).padding(.bottom)
         
            Spacer()
        }
    }
}

struct PublishView_Previews: PreviewProvider {
    static var previews: some View {
        PublishView()
    }
}
