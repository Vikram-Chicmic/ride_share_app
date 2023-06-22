//
//  AllPublishedRidesView.swift
//  BlaBalApp
//
//  Created by ChicMic on 22/06/23.
//

import SwiftUI

struct PublishedRideDetailView: View {
    var selectedCardData: AllPublishRideData
    @State var navigateToVehicleDetail = false
    @State var showEditView = false
    var body: some View {
        ScrollView {
            VStack {
                Image("carbg").resizable().scaledToFit()
                if let data = selectedCardData {
                
                        
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
                    RideDetailTileView(title: "Price", value: String(data.setPrice))
                    Divider()
                    HStack {
                        RideDetailTileView(title: "Vehicle", value: RegisterVehicleViewModel.shared.specificVehicleDetails?.vehicleBrand ?? "Can't Fetch")
                        Image(systemName: Constants.Icons.rightChevron)
                    }.onTapGesture {
                        self.navigateToVehicleDetail.toggle()
                       
                    }.navigationDestination(isPresented: $navigateToVehicleDetail) {
                        VehicleDetailView( isComingFromPublishView: .constant(true))
                    }
                    
                    Divider()
                    Button {
                        MapAndSearchRideViewModel.shared.publishId = data.id
                        print()
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
                        self.showEditView.toggle()
                        
                    } label: {
                        HStack {
                            HollowButton(image: "", text: "Edit Ride", color: data.status == "pending" ? Constants.Colors.bluecolor : Color.gray)
                        }
                    }.disabled(data.status == "cancelled").navigationDestination(isPresented: $showEditView) {
                        LocationView(isPublishView: .constant(true), isComingFromPublishedView: .constant(true))
                    }
                    
                
                    
                } else {
                    /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                }
                
                Divider()
                 
                Button {
                    MapAndSearchRideViewModel.shared.publishId = selectedCardData.id
                    MapAndSearchRideViewModel.shared.apiCall(for: .cancelRide)
                } label: {
                    HStack {
                        Buttons(image: "", text: "Cancel Ride", color: selectedCardData.status == "pending" ? Color.red : Color.gray)
                    }
                }.disabled(selectedCardData.status == "cancelled")
                Spacer()
            }.onAppear {
                RegisterVehicleViewModel.shared.getVehicleId = selectedCardData.vehicleID
                RegisterVehicleViewModel.shared.apiCall(method: .getVehicleDetailsById)
               
        }.padding().navigationTitle("Published Ride Detail")
        }.scrollIndicators(.hidden)
    }
}

struct AllPublishedRidesView_Previews: PreviewProvider {
    static var previews: some View {
        PublishedRideDetailView(selectedCardData:  AllPublishRideData(id: 461, source: "Elante Mall", destination: "VRP Telematics Private Limited", passengersCount: 4, addCity: nil, date: "2023-06-29", time: "2000-01-01T04:38:00.000Z", setPrice: 2500, aboutRide: "Adas", userID: 221, createdAt: "2023-06-21T11:27:41.551Z", updatedAt: "2023-06-21T11:27:41.551Z", sourceLatitude: 30.70549299999999, sourceLongitude: 76.8012561, destinationLatitude: 28.5193495, destinationLongitude: 77.28101509999999, vehicleID: 243, bookInstantly: nil, midSeat: nil, selectRoute: nil, status: "pending", estimateTime: "2000-01-01T01:00:00.000Z", addCityLongitude: nil, addCityLatitude: nil))
    }
}
