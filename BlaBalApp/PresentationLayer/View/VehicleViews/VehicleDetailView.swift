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
    @Binding var isComingFromPublishView: Bool
    var index: Int?
    var body: some View {
        ZStack {
            VStack {
                Image(Constants.Images.carbg).resizable().scaledToFit()
                if isComingFromPublishView {
                    if let data = vm.specificVehicleDetails {
                        Text(data.vehicleBrand).fontWeight(.semibold).font(.title)
                        VStack(spacing: 10) {
                            RideDetailTileView(title: Constants.Texts.model, value:data.vehicleName) //MODEL
                            RideDetailTileView(title: Constants.Texts.vehicleNumber, value: data.vehicleNumber)
                            RideDetailTileView(title: Constants.Texts.Manufactureyear, value: String(data.vehicleModelYear))
                            RideDetailTileView(title: Constants.Texts.VehicleType, value: data.vehicleType)
                            RideDetailTileView(title: Constants.Texts.color, value: data.vehicleColor)
                        }.padding().background(Color.gray.opacity(0.1)).cornerRadius(20)
                    }
                
                } else {
                    if let data = vm.decodedVehicleData?.data, let index = index {
                        Text(data[index].vehicleBrand).fontWeight(.semibold).font(.title)
                        VStack(spacing: 10) {
                            RideDetailTileView(title: Constants.Texts.model, value: data[index].vehicleName) //MODEL
                            RideDetailTileView(title: Constants.Texts.vehicleNumber, value: data[index].vehicleNumber)
                            RideDetailTileView(title: Constants.Texts.Manufactureyear, value: String(data[index].vehicleModelYear))
                            RideDetailTileView(title: Constants.Texts.VehicleType, value: data[index].vehicleType)
                            RideDetailTileView(title: Constants.Texts.color, value: data[index].vehicleColor)
                        }.padding().background(Color.gray.opacity(0.1)).cornerRadius(20)
                    }
                }
              
                Spacer()
            }.padding()
            if vm.isLoading {
                ProgressView().progressViewStyle(.circular)
            }

        }.navigationTitle("Vehicle Details").toolbar {
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
                Text(Constants.Texts.update)
            }.navigationDestination(isPresented: $navigateToUpdateView) {
                RegisterVehicleView(isUpdateVehicle: .constant(true))
            }
        }.disabled(isComingFromPublishView)
        
    }
}

struct VehicleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleDetailView(isComingFromPublishView: .constant(false)).environmentObject(RegisterVehicleViewModel())
        
        
    }
}
