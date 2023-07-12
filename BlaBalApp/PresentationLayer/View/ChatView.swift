//
//  ChatView.swift
//  BlaBalApp
//
//  Created by ChicMic on 12/07/23.
//

import SwiftUI

struct ChatView: View {
 
    var body: some View {
        HStack(spacing: 20) {
            Image("Cathy")
                .resizable()
                .scaledToFit()
                .frame(width: 50)
                .cornerRadius(50)
            
            VStack(alignment: .leading) {
                Text("Cathy")
                    .font(.title)
                    .bold()
                Text("Online").foregroundColor(.green)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }.padding()
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
