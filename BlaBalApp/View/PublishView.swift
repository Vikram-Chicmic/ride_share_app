//
//  PublishView.swift
//  BlaBalApp
//
//  Created by ChicMic on 11/05/23.
//

import SwiftUI

struct PublishView: View {
    @State var showMapView = false
    @State var isOrigin = true
    var body: some View {
        VStack {
//            Button {
//                showMapView.toggle()
//            }label: {
//                HStack(spacing: 30) {
//                    Image(systemName: Constants.Icons.circle).bold().padding(.leading).foregroundColor(.blue)
//                    Text(vm.originData?.name.isEmpty ?? true ? "Start From" : vm.originData?.name ?? "Unknown").foregroundColor(.black)
//                    Spacer()
//                }
//            }.sheet(isPresented: $showMapView, content: {
//                MapView( isOrigin: $isOrigin)
//            })
//            .padding(.top, 4)
//            .frame(height: 45)
//            Divider().padding(.horizontal)
//
//
//            // MARK: - Going to
//            Button {
//                isOrigin = false
//                showMapView.toggle()
//                } label: {
//                HStack(spacing: 30) {
//                    Image(systemName: Constants.Icons.location).bold().padding(.leading).foregroundColor(.blue)
//                    Text(vm.destinationData?.name.isEmpty ?? true ? "Going to" : vm.destinationData?.name ?? "Unknown").foregroundColor(.black)
//                    Spacer()
//                }
//            }
//            .sheet(isPresented: $showMapView, content: {
//                MapView( isOrigin: $isOrigin)
//            })
//            .frame(height: 40)
//            Divider().padding(.horizontal)
//            Spacer()
        }
    }
}

struct PublishView_Previews: PreviewProvider {
    static var previews: some View {
        PublishView()
    }
}
