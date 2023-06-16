//
//  InboxView.swift
//  BlaBalApp
//
//  Created by ChicMic on 11/05/23.
//

import SwiftUI

struct InboxView: View {
    var body: some View {
        VStack {
            HStack {
                Text(Constants.Labels.inbox).font(.largeTitle).fontWeight(.semibold)
                Spacer()}
            Text(Constants.Texts.nomsg).padding(.vertical)
            Spacer()
        }.padding()
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView()
    }
}
