//
//  NetworkStatusManager.swift
//  BlaBalApp
//
//  Created by ChicMic on 19/08/23.
//

import Foundation
import Network

class NetworkStatusManager: ObservableObject {
    private let monitor = NWPathMonitor()
    @Published var isConnected: Bool = true

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
}


import SwiftUI

struct NoInternetAlertModifier: ViewModifier {
    @Binding var isConnected: Bool

    func body(content: Content) -> some View {
        content.alert(isPresented: Binding(
            get: { !isConnected },
            set: { _ in isConnected = true }
        )) {
            Alert(
                title: Text("No Internet Connection"),
                message: Text("Please check your internet connection and try again."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

extension View {
    func alertOnNoInternet(isConnected: Binding<Bool>) -> some View {
        self.modifier(NoInternetAlertModifier(isConnected: isConnected))
    }
}
