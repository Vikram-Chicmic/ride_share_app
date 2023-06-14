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
                    ForEach(data.indices, id: \.self) { index in
                        NavigationLink {
                            VehicleDetailView( index: index)
                        } label: {
                            HStack {
                                Image("car2").resizable().frame(width: 80, height: 80).padding(.trailing)
                                Spacer()
                                Text(data[index].vehicleBrand)
                                Spacer()
                            }
                        }

                    }.onDelete { index in
                        deleteIndex = index
                        alertToDelete.toggle()
                    }
                    
                    
                } else { }
                
            }.toolbar {
              EditButton()
            }.listStyle(.plain)
        }.alert(isPresented: $alertToDelete) {
            Alert(
                title: Text("Warning"),
                message: Text("Are you sure you want to delete this item?"),
                primaryButton: .destructive(
                    Text("Delete"),
                    action: {
                        if let index = deleteIndex {
                            delete(at: index)
                        }
                    }
                ),
                secondaryButton: .cancel()
            )
        }.navigationTitle("Your Vehicles")
            .onAppear {
            vm.isRegistering = false
            vm.registerVehicle()
        }.onDisappear {

        }
    }
    func delete(at offsets: IndexSet) {
        vm.isDeletingVehicle.toggle()
        vm.deletingVehicleId = vm.decodedVehicleData?.data[offsets.first ?? 0].id
        print(vm.decodedVehicleData?.data[offsets.first ?? 0].id)
        vm.registerVehicle() //toggle before calling function
        dismiss()
    }
}

struct AllVehiclePage_Previews: PreviewProvider {
    static var previews: some View {
        AllVehicleView().environmentObject(RegisterVehicleViewModel())
    }
}
