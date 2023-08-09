//
//  NewProfileButton.swift
//  BlaBalApp
//
//  Created by ChicMic on 09/08/23.
//

import SwiftUI

struct ProfileOptionButton<Label: View, Destination: View>: View {
    let label: Label
    let destination: Destination
    @Binding var isPresented: Bool
    
    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            HStack {
                label
                Spacer()
                Image(systemName: Constants.Icons.rightChevron)
            }
        }
        .frame(minHeight: 30)
        .navigationDestination(isPresented: $isPresented) {
            destination
        }
    }
}
