//
//  NavigationHandler.swift
//  BlaBalApp
//
//  Created by ChicMic on 10/08/23.
//

import Foundation

import SwiftUI

final class NavigationViewModel: ObservableObject {
    
    static let shared = NavigationViewModel()

    @Published var paths: [ViewIdentifiers] = []
    
    init() {
        // change the initial views here
    }
    
    func push(_ path: ViewIdentifiers) {
        paths.append(path)
    }
    
    func pop() {
        paths = []
    }
}

enum ViewIdentifiers {
    case landingView
    case tabView
}
