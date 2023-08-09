//
//  ViewExtension.swift
//  BlaBalApp
//
//  Created by ChicMic on 19/06/23.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    // function for keyboard handling
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
