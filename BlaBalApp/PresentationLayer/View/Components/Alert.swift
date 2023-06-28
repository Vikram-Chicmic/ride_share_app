//
//  Alert.swift
//  BlaBalApp
//
//  Created by ChicMic on 12/05/23.
//

import SwiftUI

struct CustomAlert: View {

    
    var text: String
    @Binding var dismiss: Bool
    var body: some View {
        HStack {
            Text(text)
            Spacer()
            Button {
                dismiss.toggle()
            }label: {
                Image(systemName: Constants.Icons.cross)
            }
        }.padding().background(.red).cornerRadius(10).foregroundColor(.white).padding()
    }
}

struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlert(text: Constants.Alert.invalidemail, dismiss: .constant(false))
    }
}
