//
//  UnderlineView.swift
//  BlaBalApp
//
//  Created by ChicMic on 13/06/23.
//

import SwiftUI

struct UnderlineView: View {
    var body: some View {
        HStack {
            Capsule().fill(Color.blue).frame(maxWidth: .infinity, maxHeight: 3)
        }
    }
}

struct UnderlineView_Previews: PreviewProvider {
    static var previews: some View {
        UnderlineView()
    }
}
