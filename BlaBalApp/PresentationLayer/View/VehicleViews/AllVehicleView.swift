//
//  AllVehiclePage.swift
//  BlaBalApp
//
//  Created by ChicMic on 01/06/23.
//

import SwiftUI

struct AllVehicleView: View {
    @EnvironmentObject var vm: RegisterVehicleViewModel
    @EnvironmentObject var baseAPI: BaseApiManager
    @State var alertToDelete = false
    @State var navigateToRegisterVehicle = false
    @State var deleteIndex: IndexSet?
    @State var editMode: EditMode = .inactive
    @State var isEditing = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            if let data = vm.decodedVehicleData?.data {
                if data.count > 0 {
                    List {
                        ForEach(data.indices, id: \.self) { index in
                            NavigationLink {
                                VehicleDetailView(isComingFromPublishView: .constant(false), index: index)
                            } label: {
                                    HStack(alignment: .center) {
                                        Image(Constants.Images.car2).resizable().frame(width: 40, height: 40).padding(.trailing, 50)
                                        Text(data[index].vehicleBrand)
                                        Spacer()
                                    }.cornerRadius(20)
                            }.listRowSeparator(.hidden)
                              
                        }.onDelete { index in
                            deleteIndex = index
                            alertToDelete.toggle()
                        }
                    }.listStyle(.plain).environment(\.editMode, $editMode)
                        .refreshable {
                        vm.apiCall(method: .getVehicle)
                    }.toolbar {
                        Button {
                            navigateToRegisterVehicle.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }.navigationDestination(isPresented: $navigateToRegisterVehicle) {
                                                            RegisterVehicleView(isUpdateVehicle: .constant(false), hasUpdated: .constant(false))
                                                        }
                        
                        Button {
                            withAnimation {
                                isEditing.toggle()
                            }
                            editMode = isEditing ? .active : .inactive
                        } label: {
                            Image(systemName: "trash").foregroundColor(.red)
                        }
                      }.listStyle(.plain)
                        .actionSheet(isPresented: $alertToDelete) {
                            ActionSheet(title: Text("Delete Vehicle"), message: Text("You sure you want to delete? "), buttons: [.destructive(Text("Delete"), action: {
                                if let index = deleteIndex {
                                    delete(at: index)
                                }
                            }), .cancel(Text("Cancel"), action: {
                                editMode = .inactive
                            })])
                        }
                } else {
                    VStack {
                        Image("carsaf").resizable().scaledToFit().frame(width: 300)
                        Text("No vehicle found").foregroundColor(.blue).font(.title).bold()
                    }
                }
            }
        }
        .navigationTitle("Your Vehicles")
        .onAppear {
            vm.isRegistering = false
            vm.isDeletingVehicle = false
            vm.isUpdatingVehicle = false
            vm.apiCall(method: .getVehicle)
//            dismiss()
        }
//        .alert(isPresented: $vm.failAlert) {
//            Alert(title: Text("error"), message: Text(ErrorAlert.getVehicle.rawValue), dismissButton: .cancel(Text("Ok"), action: {}))
//        }
        .onDisappear {
            vm.isDeletingVehicle = false
        }
    }
    
    // MARK: - Delete a vehicle with indexValue
    func delete(at offsets: IndexSet) {
        vm.isDeletingVehicle = true
        vm.deletingVehicleId = vm.decodedVehicleData?.data[offsets.first ?? 0].id
        print(vm.decodedVehicleData?.data[offsets.first ?? 0].id)
        vm.apiCall(method: .deleteVehicle )
//        dismiss()
        //toggle before calling function
        editMode = .inactive
    }
    
}

struct AllVehiclePage_Previews: PreviewProvider {
    static var previews: some View {
        AllVehicleView().environmentObject(RegisterVehicleViewModel())
    }
}
