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
    @EnvironmentObject var networkStatusManager: NetworkStatusManager
    @State var editMode: EditMode = .inactive
    @State var isEditing = false
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
                            } else {
                                HStack {
                                    Spacer()
                                    VStack(alignment: .center){
                                        Image("carsaf").resizable().scaledToFit().frame(width: 200)
                                        Text("No vehicle found").font(.title3).bold()
                                    }
                                    Spacer()
                                }                            }
                        } else {
                            HStack {
                                Spacer()
                                VStack(alignment: .center){
                                    Image("carsaf").resizable().scaledToFit().frame(width: 200)
                                    Text("No vehicle found").font(.title3).bold()
                                }
                                Spacer()
                            }
                           
                        }
                    }.listStyle(.plain).environment(\.editMode, $editMode)
                        .refreshable {
                        vm.apiCallForVehicles(method: .getVehicle)
                    }.toolbar {
                        Button {
                            navigateToRegisterVehicle.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }.navigationDestination(isPresented: $navigateToRegisterVehicle) {
                                                            RegisterVehicleView(isUpdateVehicle: .constant(false), hasUpdated: .constant(false))
                                                        }
                        if vm.decodedVehicleData?.data != nil || vm.decodedVehicleData?.data.count != 0 {
                            Button {
                                withAnimation {
                                    isEditing.toggle()
                                }
                                editMode = isEditing ? .active : .inactive
                            } label: {
                                Image(systemName: "trash").foregroundColor(.red)
                            }
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
        }
        .navigationTitle("Your Vehicles")
        .onAppear {
            vm.isRegistering = false
            vm.isDeletingVehicle = false
            vm.isUpdatingVehicle = false
            vm.apiCallForVehicles(method: .getVehicle)
//            dismiss()
        }
        .overlay(
            VStack {
                if vm.isLoading  {
                    Spacer() // Push the ProgressView to the top
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                }
                Spacer() // Push the following content to the bottom
                if vm.showToast  {
                    CustomAlert(text:vm.toastMessage, dismiss:  $vm.showToast)
                        .onAppear {
                            // Automatically hide the toast message after a delay
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    vm.showToast = false
                                }
                               
                            }
                        }
                     
                        .animation(.default)
                }
            }
        )
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
        vm.apiCallForVehicles(method: .deleteVehicle )
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
