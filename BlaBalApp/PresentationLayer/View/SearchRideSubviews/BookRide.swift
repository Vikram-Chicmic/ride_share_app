//
//  BookRide.swift
//  BlaBalApp
//
//  Created by ChicMic on 12/06/23.
//

import SwiftUI

struct BookRide: View {
    var details: SearchRideResponseData
    @EnvironmentObject var vm: MapAndSearchRideViewModel
    @State var seats: Int = 1
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Spacer()
                Image("carbg").resizable().scaledToFit()
                Spacer()
            }
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

              

            }.padding().frame(minWidth: 380).background {
                Color.gray.opacity(0.1).cornerRadius(10)
            }
            
            HStack {
                Text(Constants.Texts.totalPrice)
                Spacer()
                Text("Rs. \(details.publish.setPrice)").font(.title2).bold()
            }.padding().background(
                Color.gray.opacity(0.1).cornerRadius(20)).padding(.vertical)
            
            Text(Constants.Buttons.numberOfSeats).fontWeight(.semibold).font(.title3).padding(.vertical).padding(.top, 50)
            HStack {
                Image(systemName: Constants.Icons.minuscircle).foregroundColor(seats > 1 ? .blue : .gray).onTapGesture {
                    if seats > 1 {
                        seats -= 1
                    }
                }
                Spacer()
                Text("\(seats)").bold()
                Spacer()
                Image(systemName: Constants.Icons.pluscircle).foregroundColor(seats < details.publish.passengersCount ? .blue : .gray).onTapGesture {
                    if seats < details.publish.passengersCount {
                        seats += 1
                    }
                
                }
            }.padding(.bottom).font(.title2)
            
            Spacer()
            Button {
                vm.publishId = details.id
                vm.noOfSeatsToBook = seats
                vm.apiCall(for: .bookRide)
            } label: {
                Buttons(image: "", text: Constants.Buttons.bookRide, color: Constants.Colors.bluecolor)
            }
            
           
            
         
        }.navigationTitle("Book Ride").padding()
    }
}

struct BookRide_Previews: PreviewProvider {
    static var previews: some View {
        BookRide(details: SearchRideResponseData(id: 256, name: "Hriday", reachTime: "2023-06-15T11:14:58.000Z", imageURL: nil, averageRating: nil, aboutRide: "", publish: BlaBalApp.Publish(id: 373, source: "Business & Indu", destination: "Sector 118, Mohali", passengersCount: 1, addCity: nil, date: "2023-06-15", time: "2000-01-01T10:41:00.000Z", setPrice: 200, aboutRide: "", userID: 256, createdAt: "2023-06-12T05:12:43.252Z", updatedAt: "2023-06-12T06:42:49.717Z", sourceLatitude: 30.704758007382228, sourceLongitude: 76.801208, destinationLatitude: 30.737185, destinationLongitude: 76.678551, vehicleID: 218, bookInstantly: nil, midSeat: nil, selectRoute: BlaBalApp.SelectRoute(), status: "pending", estimateTime: "2000-01-01T00:33:58.000Z", addCityLongitude: nil, addCityLatitude: nil, distance: 0.08185672694379517, bearing: "183.744259068662")))
    }
}
