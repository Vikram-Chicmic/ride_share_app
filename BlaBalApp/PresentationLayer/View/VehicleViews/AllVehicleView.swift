//
//  AllVehiclePage.swift
//  BlaBalApp
//
//  Created by ChicMic on 01/06/23.
//

import SwiftUI

struct AllVehicleView: View {
    @EnvironmentObject var vm: RegisterVehicleViewModel
    @State var alertToDelete = false
    @State var deleteIndex: IndexSet?
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            
            List {
                if let data = vm.decodedVehicleData?.data {
                    
                    if data.count > 0 {
                        ForEach(data.indices, id: \.self) { index in
                            NavigationLink {
                                VehicleDetailView(isComingFromPublishView: .constant(false), index: index)
                            } label: {
                                HStack {
                                    Image(Constants.Images.car2).resizable().frame(width: 80, height: 80).padding(.trailing)
                                    Spacer()
                                    Text(data[index].vehicleBrand)
                                    Spacer()
                                }
                            }

                        }.onDelete { index in
                            deleteIndex = index
                            alertToDelete.toggle()
                        }
                        
                    } else {
                        VStack {
                            Image("carsaf").resizable().scaledToFit().frame(width: 300)
                            Text("No vehicle found").foregroundColor(.blue).font(.title).bold()
                        }
                    }
                   
                    
                } else { }
            }.toolbar {
              EditButton()
            }.listStyle(.plain)
            
         
            
        }.alert(isPresented: $alertToDelete) {
            Alert(
                title: Text(Constants.Alert.warning),
                message: Text(Constants.Alert.deleteItem),
                primaryButton: .destructive(
                    Text(Constants.Alert.delete),
                    action: {
                        if let index = deleteIndex {
                            delete(at: index)
                        }
                    }
                ),
                secondaryButton: .cancel()
            )
        }
        .navigationTitle("Your Vehicles")
        .onAppear {
            vm.isRegistering = false
            vm.isDeletingVehicle = false
            vm.isUpdatingVehicle = false
            vm.apiCall(method: .getVehicle)
        }.onDisappear {
            vm.isDeletingVehicle = false
        }
    }
    
    // MARK: - Delete a vehicle with indexValue
    func delete(at offsets: IndexSet) {
        vm.isDeletingVehicle = true
        vm.deletingVehicleId = vm.decodedVehicleData?.data[offsets.first ?? 0].id
        print(vm.decodedVehicleData?.data[offsets.first ?? 0].id)
        vm.apiCall(method: .deleteVehicle ) //toggle before calling function
        dismiss()
    }
    
}

struct AllVehiclePage_Previews: PreviewProvider {
    static var previews: some View {
        AllVehicleView().environmentObject(RegisterVehicleViewModel())
    }
}
