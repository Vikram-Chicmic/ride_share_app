//
//  EditRide.swift
//  BlaBalApp
//
//  Created by ChicMic on 29/06/23.
//

import SwiftUI

struct EditRide: View {
    @State var navigateToLocationUpdate: Bool = false
    @State var navigateToPriceUpdate: Bool = false
    @State var navigateToDateUpdate: Bool = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: MapAndSearchRideViewModel
    var body: some View {
        VStack {
            
            Button {
            
                navigateToLocationUpdate.toggle()
            } label: {
                HStack {
                    Text("Itinerary details")
                    Spacer()
                    Image(systemName: Constants.Icons.rightChevron)
                }
            }
          
            .navigationDestination(isPresented: $navigateToLocationUpdate) {
                LocationUpdate()
            }.padding()
    
            Divider().padding(.horizontal)
            
            
            
            
            Button {
                navigateToPriceUpdate.toggle()
            } label: {
                HStack {
                    Text("Price and Seats")
                    Spacer()
                    Image(systemName: Constants.Icons.rightChevron)
                }
            }.navigationDestination(isPresented: $navigateToPriceUpdate) {
                UpdatePriceAndSeats()
            }.padding()
    
            Divider().padding(.horizontal)
            
            Button {
                navigateToDateUpdate.toggle()
            } label: {
                HStack {
                    Text("Date and Vehicle")
                    Spacer()
                    Image(systemName: Constants.Icons.rightChevron)
                }
            }.navigationDestination(isPresented: $navigateToDateUpdate) {
                DateAndVehicleUpdate()
            }.padding()
    
            Divider().padding(.horizontal)
            
            Spacer()
        }.onAppear {
            if vm.isUpdatedSuccess {
                dismiss()
                vm.isUpdatedSuccess = false
            }
        }.navigationTitle("Update Ride")
    }
}

struct EditRide_Previews: PreviewProvider {
    static var previews: some View {
        EditRide().environmentObject(RegisterVehicleViewModel())
    }
}
