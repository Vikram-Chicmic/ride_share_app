//
//  CarPoolDetailView.swift
//  BlaBalApp
//
//  Created by ChicMic on 26/05/23.
//

import SwiftUI

struct CarPoolDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var viewHeight: CGFloat = 0
    @State var secondViewHeight: CGFloat = 0
    @State var progressHeight: CGFloat = 0
    @State var navigateToBookRide = false
    var details: SearchRideResponseData
    var body: some View {
                VStack(alignment: .leading) {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: Constants.Icons.back).fontWeight(.semibold).font(.title)
                        }
                        Spacer()
                        Text(Constants.Header.rideDetails).bold().font(.title2)
                        Spacer()
                    }
                   
                    Divider()
                  
                  
                    ScrollView {
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading, spacing: 30) {
                                 HStack {
                                     Image(systemName: Constants.Icons.circle).foregroundColor(.blue)
                                     VStack(alignment: .leading) {
                                         Text(Helper().formatDate(details.publish.time) ?? "").font(.subheadline)
                                         Text("\(details.publish.source)").bold()
                                     }
                                 }
                                HStack {
                                    Image(systemName: Constants.Icons.circle).foregroundColor(.blue)
                                    VStack(alignment: .leading) {
                                        Text(Helper().formatDate(details.reachTime) ?? "").font(.subheadline)
                                        Text("\(details.publish.destination)").bold()
                                    }
                                }
                             
                              
                             }.padding(.vertical)

                            Divider()
                            
                            Text("Details").font(.title3).fontWeight(.semibold).padding(.vertical)
                            VStack(spacing: 10) {
                                RideDetailTileView(title: Constants.Texts.deptTime, value: Helper().formatDate(details.publish.time) ?? "")
                                RideDetailTileView(title: Constants.Texts.estTime, value: "2 Hours")
                                RideDetailTileView(title: Constants.Texts.passengers, value: String(details.publish.passengersCount))
                                RideDetailTileView(title: Constants.Texts.reachTime, value: Helper().formatDate(details.reachTime) ?? "")
                                RideDetailTileView(title: Constants.Texts.ridestatus, value: details.publish.status)
                            }
                            
                            Divider()
                            
                            VStack {
                                HStack {
                                    Text(Constants.Texts.totalPrice)
                                    Spacer()
                                    Text("Rs. \(details.publish.setPrice)").font(.title2).bold()
                                }.padding().background(
                                    Color.gray.opacity(0.1).cornerRadius(20)).padding(.vertical)
                                
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(details.name).font(.title3)
                                        HStack {
                                            Image(systemName: Constants.Icons.star)
                                            Image(systemName: Constants.Icons.star)
                                            Image(systemName: Constants.Icons.star)
                                            Image(systemName: Constants.Icons.star)
                                            Image(systemName: Constants.Icons.starHollow)
                                            
                                        }.foregroundColor(.yellow)
                                    }
                                    Spacer()
                                    Image("boy").resizable().frame(width: 50).clipShape(Circle()).scaledToFit()
                                }.frame(height: 100).padding().background(
                                    Color.gray.opacity(0.1).cornerRadius(20)).padding(.vertical)
                                
                                Button {
                                    navigateToBookRide.toggle()
                                } label: {
                                    HStack {
                                        Spacer()
                                        Text(Constants.Buttons.bookRide).font(.title3).bold()
                                        Spacer()
                                    }
                                }.padding(.vertical).background(
                                    Color.gray.opacity(0.1).cornerRadius(20))
                                .navigationDestination(isPresented: $navigateToBookRide) {
                                    BookRide(details: details)
                                }
                            }
                        }
                    }.scrollIndicators(.hidden)
                    Spacer()
                }.navigationBarBackButtonHidden(true).padding()
            
        
    }
}

struct CarPoolDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CarPoolDetailView(details: SearchRideResponseData(id: 256, name: "Hriday", reachTime: "2023-06-15T11:14:58.000Z", imageURL: nil, averageRating: nil, aboutRide: "", publish: BlaBalApp.Publish(id: 373, source: "Business & Industrial Park 1, Chandigarh", destination: "Sector 118, Mohali", passengersCount: 1, addCity: nil, date: "2023-06-15", time: "2000-01-01T10:41:00.000Z", setPrice: 200, aboutRide: "", userID: 256, createdAt: "2023-06-12T05:12:43.252Z", updatedAt: "2023-06-12T06:42:49.717Z", sourceLatitude: 30.704758007382228, sourceLongitude: 76.801208, destinationLatitude: 30.737185, destinationLongitude: 76.678551, vehicleID: 218, bookInstantly: nil, midSeat: nil, selectRoute: BlaBalApp.SelectRoute(), status: "pending", estimateTime: "2000-01-01T00:33:58.000Z", addCityLongitude: nil, addCityLatitude: nil, distance: 0.08185672694379517, bearing: "183.744259068662")))
    }
}
