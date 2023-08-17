//
//  DateAndVehicleUpdate.swift
//  BlaBalApp
//
//  Created by ChicMic on 07/07/23.
//

import SwiftUI

struct DateAndVehicleUpdate: View {
    @State var newSelectedDate: Date? = Date()
    @EnvironmentObject var vehicleVm: RegisterVehicleViewModel
    @EnvironmentObject var vm: MapAndRidesViewModel
    @State var selectedVehicle: Datum?
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            // MARK: - Time
            HStack {
                Image(systemName: Constants.Icons.clock).font(.title2).foregroundColor(.blue).padding(.leading).bold()
                DatePickerTextField(placeholder: "", date: $newSelectedDate, pickerType: PickerType.date).padding(.leading).frame(height: 60).background(Color.gray.opacity(0.1).cornerRadius(25)).padding(.vertical).padding(.trailing, 8)
                Spacer()
            }
            
            // MARK: - Vehicle Selection
            HStack {
                Image(systemName: Constants.Icons.carfill)
                    .font(.title3)
                    .foregroundColor(.blue)
                    .bold()
                Menu {
                       if let data = vehicleVm.decodedVehicleData?.data {
                           ForEach(data.indices, id: \.self) { index in
                               Button {
                                   selectedVehicle = data[index]
                                   vm.vehicleId = data[index].id
                               } label: {
                                   Text("\(data[index].vehicleBrand)")
                               }
                           }
                       }
                   } label: {
                       HStack {
                           Text(selectedVehicle?.vehicleBrand ?? vehicleVm.specificVehicleDetails?.vehicleBrand ?? "Select Vehicle").padding(.leading, 12).foregroundColor(.black)
                           Spacer()
                           Image(systemName: Constants.Icons.rightChevron).foregroundColor(.blue).padding(.trailing)
                       }
                   }
                   .frame(height: 60).background(Color.gray.opacity(0.1).cornerRadius(25))
            }.padding(.horizontal)
            
            Button {
                vm.isUpdatedSource = vm.originData != nil ? true :  false
                vm.isUpdatedDestination =  vm.destinationData != nil ? true : false
                vm.date = Helper().dateToString(selectedDate: newSelectedDate ?? Date())
                vm.apiCall(for: .updateRide)
            } label: {
                Buttons(image: "", text: Constants.Texts.update, color: Constants.Colors.bluecolor).padding()
            }.alert(isPresented: $vm.updateRideSuccess) {
                Alert(title: Text(Constants.Alert.success), message: Text(SuccessAlerts.updateRide.rawValue), dismissButton: .cancel(Text(Constants.Buttons.ok), action: {
                    dismiss()
                }))
            }
            Spacer()
        }.navigationTitle("Update Date and Vehicle").onAppear {
            self.newSelectedDate = Helper().stringTodate(date: vm.date)
        }
    }
}

struct DateAndVehicleUpdate_Previews: PreviewProvider {
    static var previews: some View {
        DateAndVehicleUpdate().environmentObject(MapAndRidesViewModel())
            .environmentObject(RegisterVehicleViewModel())
    }
}
