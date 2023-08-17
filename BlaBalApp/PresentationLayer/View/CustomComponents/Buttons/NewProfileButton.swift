//
//  NewProfileButton.swift
//  BlaBalApp
//
//  Created by ChicMic on 09/08/23.
//

import SwiftUI

struct ProfileOptionButton<Label: View, Destination: View>: View {
    @Environment(\.colorScheme) var colorScheme
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
        .foregroundColor(colorScheme == .dark ? .white : .black)
        .navigationDestination(isPresented: $isPresented) {
            destination
        }
    }
}
