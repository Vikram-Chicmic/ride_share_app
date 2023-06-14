//
//  VehicleDetailView.swift
//  BlaBalApp
//
//  Created by ChicMic on 14/06/23.
//

import SwiftUI

struct VehicleDetailView: View {
    @EnvironmentObject var vm: RegisterVehicleViewModel
    @State var navigateToUpdateView = false
    var index: Int?
    var body: some View {
        VStack {
            Image("carbg").resizable().scaledToFit()
            if let data = vm.decodedVehicleData?.data, let index = index {
                Text(data[index].vehicleBrand).fontWeight(.semibold).font(.title)
                VStack(spacing: 10) {
                    RideDetailTileView(title: "Model", value: data[index].vehicleName) //MODEL
                    RideDetailTileView(title: "Vehicle Number", value: data[index].vehicleNumber)
                    RideDetailTileView(title: "Manufactured year", value: String(data[index].vehicleModelYear))
                    RideDetailTileView(title: "Vehicle Type", value: data[index].vehicleType)
                    RideDetailTileView(title: "Color", value: data[index].vehicleColor)
                }.padding().background(Color.gray.opacity(0.1)).cornerRadius(20)
            }
            Spacer()
        }.padding().navigationTitle("Vehicle Details").toolbar {
            Button {
                if let data = vm.decodedVehicleData?.data, let index = index {
                    vm.vehicleBrand = data[index].vehicleBrand
                    vm.vehicleModel = data[index].vehicleName //MODEL
                    vm.plateNumber =  data[index].vehicleNumber
                    vm.madeYear =  String(data[index].vehicleModelYear)
                    vm.selectedVehicleType = data[index].vehicleType
                    vm.selectedVehicleColor = data[index].vehicleColor
                    vm.selectedCountry = data[index].country
                    vm.updatingVehicleId = data[index].id
                }
                navigateToUpdateView.toggle()
                
            } label: {
                Text("Update")
            }.navigationDestination(isPresented: $navigateToUpdateView) {
            
                RegisterVehicleView(isUpdateVehicle: .constant(true))
            }

        }
        
    }
}

struct VehicleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleDetailView().environmentObject(RegisterVehicleViewModel())
        
        
    }
}
