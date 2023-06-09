//
//  LocationUpdate.swift
//  BlaBalApp
//
//  Created by ChicMic on 07/07/23.
//

import SwiftUI

struct LocationUpdate: View {
    @State var showMapView = false
    @State var isOrigin = true
    @EnvironmentObject var vm: MapAndSearchRideViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Button {
                showMapView.toggle()
            }label: {
                HStack(spacing: 30) {
                    Image(systemName: Constants.Icons.circle).bold().padding(.leading).foregroundColor(.blue)
                    if vm.originData == nil {
                        Text(vm.updatedOriginName ?? "Start From").foregroundColor(.black)
                    } else {
                        Text(vm.originData?.name ?? "Start From").foregroundColor(.black)
                    }
                    
                    Spacer()
                }
            }.padding().background(content: {
                Color.gray.opacity(0.22).cornerRadius(25)
            }).padding(.horizontal).padding(.top).sheet(isPresented: $showMapView, content: {
                MapView(isOrigin: $isOrigin)
            })
           
            
            Button {
                showMapView.toggle()
                isOrigin.toggle()
            }label: {
                HStack(spacing: 30) {
                    Image(systemName: Constants.Icons.circle).bold().padding(.leading).foregroundColor(.blue)
                    if vm.destinationData == nil {
                        Text(vm.updatedDestinationName ?? "Destination").foregroundColor(.black)
                    } else {
                        Text(vm.destinationData?.name ?? "Destination").foregroundColor(.black)
                    }
                    Spacer()
                }
            }.padding().background(content: {
                Color.gray.opacity(0.22).cornerRadius(25)
            }).padding(.horizontal).sheet(isPresented: $showMapView, content: {
                MapView(isOrigin: $isOrigin)
            })
            
            
            Button {
                if vm.originData != nil {
                    vm.isUpdatedSource = true
                }
                if vm.destinationData != nil {
                    vm.isUpdatedDestination = true
                }
                
                vm.apiCall(for: .updateRide)
                
            } label: {
                Buttons(image: "", text: Constants.Texts.update, color: Constants.Colors.bluecolor).padding()
            }.alert(isPresented: $vm.updateRideSuccess) {
                Alert(title: Text(Constants.Alert.success), message: Text(SuccessAlerts.updateRide.rawValue), dismissButton: .cancel(Text(Constants.Buttons.ok), action: {
                    dismiss()
                }))
            }

           
            
            
            Spacer()
        }.onAppear {
            vm.originData = nil
            vm.destinationData = nil
        }.onDisappear {
            vm.destinationData = nil
            vm.originData = nil
        }.navigationTitle("Location Update")
    }
}

struct LocationUpdate_Previews: PreviewProvider {
    static var previews: some View {
        LocationUpdate().environmentObject(MapAndSearchRideViewModel())
    }
}
