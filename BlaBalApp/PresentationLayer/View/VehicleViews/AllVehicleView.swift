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
                                VStack {
                                    HStack {
                                        Image(Constants.Images.car2).resizable().frame(width: 80, height: 80).padding(.trailing, 50)
                                       
                                        Text(data[index].vehicleBrand)
                                        Spacer()
                                    }
                                    Divider()
                                }
                            }
                            .listRowSeparator(.hidden)
                        }.onDelete { index in
                            deleteIndex = index
                            alertToDelete.toggle()
                        }
                    }.environment(\.editMode, $editMode)
                        .refreshable {
                        vm.apiCall(method: .getVehicle)
                    }.toolbar {
                        Button("Delete", action: {
                            withAnimation {
                                isEditing.toggle()
                            }
                    
                        editMode = isEditing ? .active : .inactive
                        })
//                        EditButton()
                      }.listStyle(.plain)
                        .actionSheet(isPresented: $alertToDelete) {
                            ActionSheet(title: Text("Delete Vehicle"), message: Text("You sure you want to delete? "), buttons: [.destructive(Text("Delete"), action: {
                                if let index = deleteIndex {
                                    delete(at: index)
                                }
                            }), .cancel()])
                        }
                } else {
                    VStack {
                        Image("carsaf").resizable().scaledToFit().frame(width: 300)
                        Text("No vehicle found").foregroundColor(.blue).font(.title).bold()
                    }
                }
            }
            
            
          
         
            
        }
        .onChange(of: alertToDelete, perform: { newValue in
            print(alertToDelete)
        })
        .navigationTitle("Your Vehicles")
        .onAppear {
            vm.isRegistering = false
            vm.isDeletingVehicle = false
            vm.isUpdatingVehicle = false
            vm.apiCall(method: .getVehicle)
        }.alert(isPresented: $vm.failAlert) {
            Alert(title: Text("error"), message: Text(ErrorAlert.getVehicle.rawValue), dismissButton: .cancel(Text("Ok"), action: {}))
        }
        .onDisappear {
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
