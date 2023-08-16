//
//  AllPublishedRidesView.swift
//  BlaBalApp
//
//  Created by ChicMic on 22/06/23.
//

import SwiftUI

//struct PublishedRideDetailView: View {
//    var selectedCardData: AllPublishRideData?
//    @Binding var isPublishedRide: Bool
//    @State var showEditView = false
//    @EnvironmentObject var baseApi: BaseApiManager
//    @EnvironmentObject var vm: MapAndRidesViewModel
//    @EnvironmentObject var vmm: LoginSignUpViewModel
//    @Environment(\.dismiss) var dismiss
//    @State var showAlert = false
//    @State var vehicleName: String = ""
//    var indexValue: Int?
//    @State var navigate = false
//    var body: some View {
//
//            VStack {
//                ScrollView {
//                Image("carPool2").resizable().scaledToFit().opacity(0.8)
//                if let data = selectedCardData  {
//                        HStack {
//                            Image(systemName: Constants.Icons.clock).foregroundColor(.blue)
//                            Text(Helper().formatDateToMMM(data.date))
//
//
//                        }.padding()
//
//                    HStack(spacing: 20) {
//                        VStack {
//                            Image(systemName: Constants.Icons.circle).foregroundColor(.blue)
//                            HStack {
//                                Divider().frame(height: 20)
//                            }
//                            Image(systemName: Constants.Icons.circle).foregroundColor(.blue)
//                        }.padding(.leading)
//
//                        VStack(alignment: .leading, spacing: 30) {
//                                 VStack(alignment: .leading) {
//
//                                     Text(data.source).bold()
//                                 }
//
//
//                                VStack(alignment: .leading) {
//                                    Text("\(data.destination)").bold()
//                            }
//                         }.padding(.vertical)
//                        Spacer()
//                    }
//
//                    Divider()
//                    HStack {
//                        Text("Status:").font(.title3)
//                        Spacer()
//                        VStack {
//                            Text(data.status).padding(12).font(.system(size: 12)).foregroundColor(.white)
//                        }.background(data.status == "pending" ? Color.green : Color.red).cornerRadius(10)
//                    }
//                    Divider()
//                    RideDetailTileView(title: "Price", value: String(data.setPrice)).padding(.vertical)
//                    Divider()
//                    HStack {
//                        RideDetailTileView(title: "Vehicle", value: vehicleName)
//
//                    }.padding(.vertical)
//                } else {
//                    /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
//                }
//
////                    VehicleDetailView(isComingFromPublishView: .constant(true)).padding(-15)
//
//                    if let data = vmm.decodedData {
//                        HStack {
//                            VStack(alignment: .leading) {
//                                Text(data.user.firstName+data.user.lastName).font(.title3)
//                                HStack {
//
//
//                                }.foregroundColor(.yellow)
//                            }
//                            Spacer()
//                            if let imageURL = URL(string: data.imageURL ?? "") {
//                             AsyncImage(url: imageURL) { phase in
//                                 switch phase {
//                                 case .empty:
//                                     ProgressView()
//                                         .progressViewStyle(CircularProgressViewStyle())
//                                 case .success(let image):
//                                     image.resizable().frame(width: 80).clipShape(Circle()).scaledToFit()
//                                 case .failure(_):
//                                     // Show placeholder for failed image load
//                                     Image("Cathy").resizable().scaledToFit().frame(width: 80).clipShape(Circle())
//                                 }
//                             }
//                         } else {
//                             Image("Cathy").resizable().scaledToFit().frame(width: 80).clipShape(Circle())
//                         }
//
//                            Image(systemName: Constants.Icons.rightChevron)
//                        }.frame(height: 100)
//                            .padding()
//                            .background(Color.gray.opacity(0.1))
//                            .cornerRadius(20)
//                            .onTapGesture {
//                                navigate.toggle()
//                                ChatViewModel.shared.publishId = selectedCardData?.id
//                            }.navigationDestination(isPresented: $navigate) {
//                                DriverDetailView(data: data)
//                            }
//                    }
//
//
//                // show data only if it is avialable
//                if let data = selectedCardData {
//                    VStack {
//                        // editable if status of published ride is pending
//                            if isPublishedRide {
//                                if data.status == "pending"{
//                                // edit button
//                                Button {
//                                    Helper().setRideDetailsInEditMode(data: data)
//                                    self.showEditView.toggle()
//                                } label: {
//                                    HStack {
//                                        HollowButton(image: "", text: "Edit Ride", color: Constants.Colors.bluecolor )
//                                    }
//                                }.navigationDestination(isPresented: $showEditView) {
//                                   EditRide()
//                                }
//
//                                    Button {
//                                        showAlert.toggle()
//
//                                    } label: {
//                                        HStack {
//                                            Buttons(image: "", text: "Cancel Ride", color: .red)
//                                        }
//                                    }
//
//                            }
//                            }
//
////                         for bookedRide
//                        else {
//                            if (data.status != "completed") && (data.status != "cancelled") {
//                                if vm.allBookedRides?.rides[indexValue!].status != "cancel booking" {
//                                    Button {
//                                        showAlert.toggle()
////                                        MapAndSearchRideViewModel.shared.publishId = data.id
////                                        MapAndSearchRideViewModel.shared.apiCall(for: .cancelBookedRide)
//                                    } label: {
//                                        HStack {
//                                            Buttons(image: "", text: "Cancel Ride", color: .red)
//                                        }
//                                    }
//                                }
//
//                            }
//                        }
//
//
//                    }.actionSheet(isPresented: $showAlert) {
//                        ActionSheet(title: Text("Warning"), message: Text("You sure you want to cancel ride? "), buttons: [.destructive(Text("Yes"), action: {
//                            MapAndRidesViewModel.shared.publishId = data.id
//                            MapAndRidesViewModel.shared.apiCall(for: .cancelRide)
//                        }), .cancel(Text("No"))])
//                    }.alert(isPresented: $vm.alertSuccess) {
//                        vm.alertSuccess ?
//                        Alert(title: Text(Constants.Alert.success), message: Text(SuccessAlerts.cancelRide.rawValue), dismissButton: .default(Text(Constants.Buttons.ok), action: {
//                            dismiss()
//                        })) :
//                        Alert(title: Text(Constants.Alert.error), message: Text(Constants.Alert.failToCancel), dismissButton: .default(Text(Constants.Buttons.ok), action: {
//                            dismiss()
//                        }))
//
//
//
//                    }
//                    }
//
//
//                Spacer()
//            }.refreshable {
//                RegisterVehicleViewModel.shared.apiCall(method: .getVehicleDetailsById)
//            }.scrollIndicators(.hidden)
//
//
//
//
//
//        }.onAppear {
////            RegisterVehicleViewModel.shared.specificVehicleDetails = nil
////            if let data = selectedCardData {
////                RegisterVehicleViewModel.shared.getVehicleId = data.vehicleID
////                RegisterVehicleViewModel.shared.apiCall(method: .getVehicleDetailsById)
////                vehicleName = RegisterVehicleViewModel.shared.specificVehicleDetails?.vehicleBrand ?? ""
////            }
//
//        }.padding().navigationTitle(isPublishedRide ? "Published Ride Detail" : "Booked Ride Detail")
//    }
//}



struct PublishedRideDetailView: View {
    var selectedCardData: AllPublishRideData?
    @Binding var isPublishedRide: Bool
    @State var showEditView = false
    @EnvironmentObject var baseApi: BaseApiManager
    @EnvironmentObject var vm: MapAndRidesViewModel
    @EnvironmentObject var vmm: LoginSignUpViewModel
    @Environment(\.dismiss) var dismiss
    @State var showAlert = false
    @State var vehicleName: String = ""
    var indexValue: Int?
    @State var navigate = false
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                Image("carPool2").resizable().scaledToFit().opacity(0.8)
                
                if let data = selectedCardData {
                    VStack(alignment: .leading) {
                        rideInfoView(data: data)
                        rideStatusView(data: data).padding(.bottom)
                        
                        // estimated time
                        // start time
                        
                    }.background(Color.gray.opacity(0.1).cornerRadius(10))
                    
                    HStack {
                        Text("Status:").font(.title3)
                        Spacer()
                        VStack {
                            Text(data.status).padding(12).font(.system(size: 12)).foregroundColor(Helper().colorSelector(status: data.status))
                        }
                        .background(Helper().colorSelector(status: data.status).opacity(0.1))
                        .cornerRadius(10)
                    }.padding().background(Color.gray.opacity(0.1).cornerRadius(10))
                        .padding(.vertical,25)
                    HStack {
                        Text("Vehicle").font(.title2).fontWeight(.semibold)
                        Spacer()
                    }
                    
                    vehicleDetailView()
                    RideDetailTileView(title: "Price", value: "Rs. " + String(data.setPrice)).fontWeight(.semibold).font(.title2).padding().background(Color.gray.opacity(0.1).cornerRadius(10)).padding(.vertical)

                } else {
                    EmptyView()
                }
                
                if !isPublishedRide {
                    if let data = vmm.decodedData {
                        driverView(data: data)
                    }
                }
               
               
            }.scrollIndicators(.hidden)
            if let data = selectedCardData {
                actionButtonsView(data: data)
            }
        }
        .onAppear {
            if vm.isUpdatedSuccess {
                dismiss()
                vm.isUpdatedSuccess = false
            }
        }
        .padding()
        .navigationTitle(isPublishedRide ? "Published Ride Detail" : "Booked Ride Detail")
    }
    
    private func rideInfoView(data: AllPublishRideData) -> some View {
        HStack {
            Image(systemName: "calendar").foregroundColor(.blue)
            Text(Helper().formatDateToMMM(data.date))
            Spacer()
            Image(systemName: Constants.Icons.clock).foregroundColor(.blue)
            Text(Helper().datetimeFormat(dateTime: data.time, format: Constants.Date.timeFormat))
        }
        .padding(.horizontal).padding(.top)
        
      
    }
    
    private func rideStatusView(data: AllPublishRideData) -> some View {
       return HStack(spacing: 20) {
           DistanceCircleShowView(maxWidhth: 2, maxHeight: 35).padding(.leading)

            
            VStack(alignment: .leading, spacing: 30) {
                VStack(alignment: .leading) {
                    Text(data.source).bold()
                }
                VStack(alignment: .leading) {
                    Text("\(data.destination)").bold()
                }
            }
            .padding(.vertical)
            Spacer()
        }
    }
    
    private func vehicleDetailView() -> some View {
        HStack {
            VehicleDetailView(isComingFromPublishView: .constant(true)).padding(-15)
        }
       
    }
    
    private func driverView(data: DecodeUser) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(data.user.firstName + data.user.lastName).font(.title3)
                HStack {
                    // Commented out for brevity
                }
                .foregroundColor(.yellow)
            }
            Spacer()
            if let imageURL = URL(string: data.imageURL ?? "") {
                             AsyncImage(url: imageURL) { phase in
                                 switch phase {
                                 case .empty:
                                     ProgressView()
                                         .progressViewStyle(CircularProgressViewStyle())
                                 case .success(let image):
                                     image.resizable().frame(width: 80).clipShape(Circle()).scaledToFit()
                                 case .failure(_):
                                     // Show placeholder for failed image load
                                     Image("Cathy").resizable().scaledToFit().frame(width: 80).clipShape(Circle())
                                 }
                             }
                         } else {
                             Image("Cathy").resizable().scaledToFit().frame(width: 80).clipShape(Circle())
                         }
            Image(systemName: Constants.Icons.rightChevron)
        }
        .frame(height: 100)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(20)
        .onTapGesture {
            navigate.toggle()
            ChatViewModel.shared.publishId = selectedCardData?.id
        }
        .navigationDestination(isPresented: $navigate) {
            DriverDetailView(data: data)
        }
    }
    
    private func actionButtonsView(data: AllPublishRideData) -> some View {
        VStack {
            if isPublishedRide {
                if data.status == "pending" {
                    Button {
                        Helper().setRideDetailsInEditMode(data: data)
                        showEditView.toggle()
                    } label: {
                        HStack {
                            Buttons(image: "", text: "Edit Ride", color: Constants.Colors.bluecolor )
                        }
                    }
                    .navigationDestination(isPresented: $showEditView) {
                        EditRide()
                    }
                    Button {
                        showAlert.toggle()
                    } label: {
                        HStack {
                            HollowButton(image: "", text: "Cancel Ride", color: .red.opacity(0.8))
                            }
                    }

                }
            } else {
                if (data.status != "completed") && (data.status != "cancelled") {
                    if vm.allBookedRides?.rides[indexValue!].status != "cancel booking" {
                        Button {
                            showAlert.toggle()
                        } label: {
                            HStack {
                                HollowButton(image: "", text: "Cancel Ride", color: .red.opacity(0.8))
                                }
                        }
                    }
                }
            }
        }
        .actionSheet(isPresented: $showAlert) {
            ActionSheet(title: Text("Warning"), message: Text("You sure you want to cancel ride? "), buttons: [
                .destructive(Text("Yes"), action: {
                    MapAndRidesViewModel.shared.publishId = data.id
                    MapAndRidesViewModel.shared.apiCall(for: .cancelRide)
                }),
                .cancel(Text("No"))
            ])
        }
        .alert(isPresented: $vm.alertCancelRide) {
            Alert(title: Text("success"), message: Text("Ride cancelled Successfully"), dismissButton: .default(Text("Okay"),action: {
                dismiss()
            } ))
            // Commented out for brevity
        }
    }
}
