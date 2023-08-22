//
//  AllPublishedRidesView.swift
//  BlaBalApp
//
//  Created by ChicMic on 22/06/23.
//

import SwiftUI
struct PublishedRideDetailView: View {
    var selectedCardData: AllPublishRideData?
    @EnvironmentObject var networkStatusManager: NetworkStatusManager
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
                        driverView(data: data, rideData: selectedCardData)
                    }
                }
               
               
            }.scrollIndicators(.hidden)
            if let data = selectedCardData {
                actionButtonsView(data: data)
            }
        }.overlay(
            VStack {
                if vm.isLoading {
                    Spacer() // Push the ProgressView to the top
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                }
                Spacer() // Push the following content to the bottom
                if vm.showToast {
                    CustomAlert(text: vm.toastMessage, dismiss: $vm.showToast)
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
            Text(Helper().formatDateToMMM(data.date, dateFormat: Constants.Date.stringToDateForamat))
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
    
    private func driverView(data: DecodeUser, rideData: AllPublishRideData?) -> some View {
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
        .cornerRadius(10)
        .onTapGesture {
            navigate.toggle()
            ChatViewModel.shared.publishId = selectedCardData?.id
        }
        .navigationDestination(isPresented: $navigate) {
            DriverDetailView(data: data,rideData: rideData)
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
