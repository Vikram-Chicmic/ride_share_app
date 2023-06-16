//
//  SwiftUIView.swift
//  BlaBalApp
//
//  Created by ChicMic on 25/05/23.
//

import SwiftUI

struct CarPoolCard: View {
    var data: SearchRideResponseData
    var body: some View {
        VStack {
               VStack(alignment: .leading, spacing: 30) {
                    HStack {
                        Image(systemName: Constants.Icons.circle).foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text(Helper().formatDate(data.publish.time) ?? "").font(.subheadline)
                            Text("\(data.publish.source)").bold()
                        }
                    }
                   HStack {
                       Image(systemName: Constants.Icons.circle).foregroundColor(.blue)
                       VStack(alignment: .leading) {
                           Text(Helper().formatDate(data.reachTime) ?? "").font(.subheadline)
                           Text("\(data.publish.destination)").bold()
                       }
                   }
                
                 
                }.padding(.vertical)
               
                
         
            
            Divider().padding(.horizontal)
            
            HStack {
                if let image = data.imageURL {
                    Image("\(image)").resizable().frame(width: 50, height: 50).scaledToFit().clipShape(Circle())
                        .padding(.trailing, 15)
                } else {
                    Image("boy").resizable().frame(width: 50, height: 50).scaledToFit().clipShape(Circle())
                        .padding(.trailing, 15)
                }
                VStack(alignment: .leading) {
                    Text("\(data.name)").font(.system(size: 20))
                    Text(Constants.DefaultValues.noRatings).font(.subheadline).foregroundColor(.gray)
                }
                
                Spacer()
                Text("Rs. \(data.publish.setPrice)").bold()
            }.padding(.bottom)
                .padding(.horizontal)
           
            
        }.background {
            Color.gray.opacity(0.1).cornerRadius(20)
        }
       
    }
    
  

    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CarPoolCard( data: SearchRideResponseData(id: 256, name: "Hriday", reachTime: "2023-06-15T11:14:58.000Z", imageURL: nil, averageRating: nil, aboutRide: "", publish: BlaBalApp.Publish(id: 373, source: "Business & Industrial Park 1, Chandigarh", destination: "Sector 118, Mohali", passengersCount: 1, addCity: nil, date: "2023-06-15", time: "2000-01-01T10:41:00.000Z", setPrice: 200, aboutRide: "", userID: 256, createdAt: "2023-06-12T05:12:43.252Z", updatedAt: "2023-06-12T06:42:49.717Z", sourceLatitude: 30.704758007382228, sourceLongitude: 76.801208, destinationLatitude: 30.737185, destinationLongitude: 76.678551, vehicleID: 218, bookInstantly: nil, midSeat: nil, selectRoute: BlaBalApp.SelectRoute(), status: "pending", estimateTime: "2000-01-01T00:33:58.000Z", addCityLongitude: nil, addCityLatitude: nil, distance: 0.08185672694379517, bearing: "183.744259068662")))
    }
}
