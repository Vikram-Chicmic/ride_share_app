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
            if let data = data {
                VStack {
                    // MARK: Upper part of card
                    VStack {
                        HStack {
                            VStack {
                                    DistanceCircleShowView(maxWidhth: 2, maxHeight: 35).padding(.leading)
//                                    Text(Helper().dateFormatter(date: data.publish.estimateTime))
                            }
                            VStack(alignment: .leading, spacing: 30) {
                                HStack {
                                    Text("\(data.publish.source)")
                                    Spacer()
                                }
                                HStack {
                                    Text("\(data.publish.destination)")
                                    Spacer()
                                }
                             }.padding(.vertical)
                            Spacer()
                        }
                    }.padding().background {
                        Color.gray.opacity(0.1)
                    }.cornerRadius(20)
                 
                 
                   
                // MARK: Lower Part
                    VStack {
                        HStack {
                            if let imageURL = URL(string: data.imageURL ?? "") {
                             AsyncImage(url: imageURL) { phase in
                                 switch phase {
                                 case .empty:
                                     ProgressView()
                                         .progressViewStyle(CircularProgressViewStyle()).frame(width: 40, height: 40).scaledToFit().clipShape(Circle())
                                         .padding(.trailing, 15)
                                 case .success(let image):
                                     image.resizable().frame(width: 40, height: 50).scaledToFit().clipShape(Circle())
                                         .padding(.trailing, 15)
                                 case .failure:
                                     // Show placeholder for failed image load
                                     Image(systemName: Constants.Icons.perosncircle).resizable().frame(width: 40, height: 40).scaledToFit().clipShape(Circle())
                                         .padding(.trailing, 15)
                                 }
                             }
                         } else {
                             Image(systemName: Constants.Icons.perosncircle).resizable().frame(width: 40, height: 40).scaledToFit().clipShape(Circle())
                                 .padding(.trailing, 15)
                         }
                            VStack(alignment: .leading) {
                                Text("\(data.name)").font(.system(size: 20)).foregroundColor(.white)
                            }
                            
                            Spacer()
                            Text("Rs. \(data.publish.setPrice)").bold().foregroundColor(.white).bold()
                        }.padding(5)
                            .padding(.horizontal)
                        
                    }.background {
                        Image(Constants.Images.blue)
                                   .resizable()
                                   .mask(BottomCornerRadiusShape(cornerRadius: 20)).overlay {
                            TransparentBlurView(removeAllFilters: false).mask(BottomCornerRadiusShape(cornerRadius: 20))
                        }.opacity(0.9)
                }.padding(.top,-20)
            }
            } else {
                /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
            }
        }
       
    }
    
  

    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CarPoolCard( data: SearchRideResponseData(id: 256, name: "Hriday", reachTime: "2023-06-15T11:14:58.000Z", imageURL: nil, averageRating: nil, aboutRide: "", publish: BlaBalApp.Publish(id: 373, source: "Business & Industrial Park 1, Chandigarh", destination: "Sector 118, Mohali", passengersCount: 1, addCity: nil, date: "2023-06-15", time: "2000-01-01T10:41:00.000Z", setPrice: 200, aboutRide: "", userID: 256, createdAt: "2023-06-12T05:12:43.252Z", updatedAt: "2023-06-12T06:42:49.717Z", sourceLatitude: 30.704758007382228, sourceLongitude: 76.801208, destinationLatitude: 30.737185, destinationLongitude: 76.678551, vehicleID: 218, bookInstantly: nil, midSeat: nil, selectRoute: BlaBalApp.SelectRoute(), status: "pending", estimateTime: "2000-01-01T00:33:58.000Z", addCityLongitude: nil, addCityLatitude: nil, distance: 0.08185672694379517, bearing: "183.744259068662")))
    }
}
