//
//  AllPublishedRidesView.swift
//  BlaBalApp
//
//  Created by ChicMic on 22/06/23.
//

import SwiftUI

struct PublishedRideDetailView: View {
    var selectedCardData: AllPublishRideData?
    @Binding var isPublishedRide: Bool
    @State var showEditView = false
    @EnvironmentObject var baseApi: BaseApiManager
    @EnvironmentObject var vm: MapAndSearchRideViewModel
    @Environment(\.dismiss) var dismiss
    @State var vehicleName: String = ""
    var indexValue: Int?
    var body: some View {
        
            VStack {
                ScrollView {
                Image("carPool2").resizable().scaledToFit().opacity(0.8)
                if let data = selectedCardData  {
                        HStack {
                            Image(systemName: Constants.Icons.clock).foregroundColor(.blue)
                            Text(Helper().formatDateToMMM(data.date))
                            
                         
                        }.padding()
                        
                    HStack(spacing: 20) {
                        VStack {
                            Image(systemName: Constants.Icons.circle).foregroundColor(.blue)
                            HStack {
                                Divider().frame(height: 20)
                            }
                            Image(systemName: Constants.Icons.circle).foregroundColor(.blue)
                        }.padding(.leading)
                        
                        VStack(alignment: .leading, spacing: 30) {
                                 VStack(alignment: .leading) {
                    
                                     Text(data.source).bold()
                                 }
                             
                        
                                VStack(alignment: .leading) {
                                    Text("\(data.destination)").bold()
                            }
                         }.padding(.vertical)
                        Spacer()
                    }
                    
                    Divider()
                    HStack {
                        Text("Status:").font(.title3)
                        Spacer()
                        VStack {
                            Text(data.status).padding(12).font(.system(size: 12)).foregroundColor(.white)
                        }.background(data.status == "pending" ? Color.green : Color.red).cornerRadius(10)
                    }
                    Divider()
                    RideDetailTileView(title: "Price", value: String(data.setPrice)).padding(.vertical)
                    Divider()
                    HStack {
                        RideDetailTileView(title: "Vehicle", value: vehicleName)
                    
                    }.padding(.vertical)
                    
                    
      
                 
                    
                
                    
                } else {
                    /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                }
                
                    VehicleDetailView(isComingFromPublishView: .constant(true)).padding(-15)
                    
                    
                // show data only if it is avialable
                if let data = selectedCardData {
                    VStack {
                        // editable if status of published ride is pending
                      
                            if isPublishedRide {
                                if data.status == "pending"{
                                // edit button
                                Button {
                                    MapAndSearchRideViewModel.shared.publishId = data.id
                                    MapAndSearchRideViewModel.shared.originData?.name = data.source
                                    MapAndSearchRideViewModel.shared.destinationData?.name = data.destination
                                    MapAndSearchRideViewModel.shared.originData?.geometry.location.lng = data.sourceLongitude
                                    MapAndSearchRideViewModel.shared.originData?.geometry.location.lat = data.destinationLatitude
                                    MapAndSearchRideViewModel.shared.destinationData?.geometry.location.lng = data.destinationLongitude
                                    MapAndSearchRideViewModel.shared.destinationData?.geometry.location.lat = data.destinationLatitude
                                    MapAndSearchRideViewModel.shared.passengers = data.passengersCount
                                    MapAndSearchRideViewModel.shared.date = data.date
                                    MapAndSearchRideViewModel.shared.time = data.time
                                    MapAndSearchRideViewModel.shared.amount = String(data.setPrice)
                                    MapAndSearchRideViewModel.shared.vehicleId = data.vehicleID
                                    MapAndSearchRideViewModel.shared.aboutRide = data.aboutRide
                                    MapAndSearchRideViewModel.shared.estimatedTime = data.estimateTime
                                   
                                     print( MapAndSearchRideViewModel.shared.publishId,
                                            MapAndSearchRideViewModel.shared.originData?.name,
                                            MapAndSearchRideViewModel.shared.destinationData?.name,
                                            MapAndSearchRideViewModel.shared.originData?.geometry.location.lng,
                                            MapAndSearchRideViewModel.shared.originData?.geometry.location.lat,
                                            MapAndSearchRideViewModel.shared.destinationData?.geometry.location.lng,
                                            MapAndSearchRideViewModel.shared.destinationData?.geometry.location.lat,
                                            MapAndSearchRideViewModel.shared.passengers = data.passengersCount,
                                            MapAndSearchRideViewModel.shared.date,
                                            MapAndSearchRideViewModel.shared.time,
                                            MapAndSearchRideViewModel.shared.amount,
                                            MapAndSearchRideViewModel.shared.vehicleId,
                                            MapAndSearchRideViewModel.shared.aboutRide,
                                            MapAndSearchRideViewModel.shared.estimatedTime)
                                    
                                    print(   data.id,
                                              data.source,
                                             data.destination,
                                           data.sourceLongitude,
                                              data.destinationLatitude,
                                            data.destinationLongitude,
                                             data.destinationLatitude,
                                          data.passengersCount,
                                            data.date,
                                            data.time,
                                          String(data.setPrice),
                                              data.vehicleID,
                                           data.aboutRide,
                                            data.estimateTime)
                                    
                                    self.showEditView.toggle()
                                    
                                } label: {
                                    HStack {
                                        HollowButton(image: "", text: "Edit Ride", color: Constants.Colors.bluecolor )
                                    }
                                }.navigationDestination(isPresented: $showEditView) {
                                    LocationView(isPublishView: .constant(true), isComingFromPublishedView: .constant(true))
                                }
                                    
                                    Button {
                                        MapAndSearchRideViewModel.shared.publishId = data.id
                                        MapAndSearchRideViewModel.shared.apiCall(for: .cancelRide)
                                    } label: {
                                        HStack {
                                            Buttons(image: "", text: "Cancel Ride", color: .red)
                                        }
                                    }
                                    
                            }
                            }
                        
                        // for bookedRide
//                        else {
//                            if vm.allBookedRides?.rides[indexValue] == "cancel booking"
//                                Button {
//                                    MapAndSearchRideViewModel.shared.publishId = data.id
//                                    MapAndSearchRideViewModel.shared.apiCall(for: .cancelBookedRide)
//                                } label: {
//                                    HStack {
//                                        Buttons(image: "", text: "Cancel Ride", color: .red)
//                                    }
//                                }
//                            }
                        
                      
                         
                    }.alert(isPresented: $vm.alertSuccess) {
                        
                        vm.alertSuccess ?
                        Alert(title: Text(Constants.Alert.success), message: Text(SuccessAlerts.cancelRide.rawValue), dismissButton: .default(Text(Constants.Buttons.ok), action: {
                            dismiss()
                        })) :
                        Alert(title: Text(Constants.Alert.error), message: Text(Constants.Alert.failToCancel), dismissButton: .default(Text(Constants.Buttons.ok), action: {
                            dismiss()
                        }))
                        
                        
                        
                    }
                    }
                   
               
                Spacer()
            }.refreshable {
                RegisterVehicleViewModel.shared.apiCall(method: .getVehicleDetailsById)
            }.scrollIndicators(.hidden)
               
                
                
                
                
        }.onAppear {
            RegisterVehicleViewModel.shared.specificVehicleDetails = nil
            if let data = selectedCardData {
                RegisterVehicleViewModel.shared.getVehicleId = data.vehicleID
                RegisterVehicleViewModel.shared.apiCall(method: .getVehicleDetailsById)
                vehicleName = RegisterVehicleViewModel.shared.specificVehicleDetails?.vehicleBrand ?? ""
            }
           
        }.padding().navigationTitle(isPublishedRide ? "Published Ride Detail" : "Booked Ride Detail")
    }
}

struct AllPublishedRidesView_Previews: PreviewProvider {
    static var previews: some View {
        PublishedRideDetailView(selectedCardData:  AllPublishRideData(id: 461, source: "Elante Mall", destination: "VRP Telematics Private Limited", passengersCount: 4, addCity: nil, date: "2023-06-29", time: "2000-01-01T04:38:00.000Z", setPrice: 2500, aboutRide: "Adas", userID: 221, createdAt: "2023-06-21T11:27:41.551Z", updatedAt: "2023-06-21T11:27:41.551Z", sourceLatitude: 30.70549299999999, sourceLongitude: 76.8012561, destinationLatitude: 28.5193495, destinationLongitude: 77.28101509999999, vehicleID: 243, bookInstantly: nil, midSeat: nil, selectRoute: nil, status: "pending", estimateTime: "2000-01-01T01:00:00.000Z", addCityLongitude: nil, addCityLatitude: nil), isPublishedRide: .constant(false)).environmentObject(MapAndSearchRideViewModel())
    }
}
