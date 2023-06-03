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
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 20) {
                   
                    
                   
                }.padding(.trailing)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(data.publish.source)").bold()
                    Text("\(Helper().dateFormatter(date: data.publish.time))").padding(.bottom,20)
                    Text("\(data.publish.destination)").bold()
                    Text("\(Helper().dateFormatter(date: data.reachTime))")
                }
                Spacer()
                Text("\(data.publish.setPrice)").font(.title3).bold()
                
            }.padding()
            
            HStack {
                if let image = data.imageURL {
                    Image("\(image)").resizable().frame(width: 50, height: 50).scaledToFit().clipShape(Circle())
                        .padding(.trailing, 15)
                } else {
                    Image("animation").resizable().frame(width: 50, height: 50).scaledToFit().clipShape(Circle())
                        .padding(.trailing, 15)
                }
               
                Text("\(data.name)").font(.system(size: 20))
                Spacer()
                Image(systemName: "paperplane").font(.title2)
                Image(systemName: "star").font(.title2)
            }.padding(.bottom)
                .padding(.horizontal)
           
            
        }.background {
            Color.white.cornerRadius(20)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 20).strokeBorder().foregroundColor(.gray).shadow(color: .gray, radius: 1)
        }
    }
    
  

    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CarPoolCard( data: SearchRideResponseData(id: 4, name: "Adarsh", reachTime: "2023-06-30T21:12:00.000Z", imageURL: "https://0610-112-196-113-2.ngrok-free.app/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBWXM9IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--548daa37c2338c17c3e277908a2a41b32ec6e05d/90e9bd0f-ad8c-4ae6-9dd7-a471ea52f41a.jpg", averageRating: nil, aboutRide: "Jkljldsflkjfdkljl", publish: BlaBalApp.Publish(id: 286, source: "ChicMic, Phase 8B, Industrial Area, Sector 74, Sahibzada Ajit Singh Nagar, Punjab, India", destination: "Varanasi, Uttar Pradesh, India", passengersCount: 3, addCity: "punjab", date: "2023-06-30", time: "2000-01-01T05:12:00.000Z", setPrice: 2195, aboutRide: "Jkljldsflkjfdkljl", userID: 4, createdAt: "2023-06-03T10:03:53.135Z", updatedAt: "2023-06-03T10:03:53.135Z", sourceLatitude: 76.6910316, sourceLongitude: 30.7132678, destinationLatitude: 25.3176452, destinationLongitude: 82.9739144, vehicleID: nil, bookInstantly: "t", midSeat: "t", selectRoute: BlaBalApp.SelectRoute(distance: "1,095 km", estimatedTime: "16 hours 22 mins", roadName: "Agra - Lucknow Expy"), status: "pending", estimateTime: "2000-01-01T16:00:00.000Z", addCityLongitude: nil, addCityLatitude: nil, distance: 0.0, bearing: "0.0")))
    }
}
