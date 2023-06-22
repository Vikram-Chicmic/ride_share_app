//
//  PublishedRideDetailCard.swift
//  BlaBalApp
//
//  Created by ChicMic on 22/06/23.
//

import SwiftUI

struct PublishedRideDetailCard: View {
    var publishRideData: AllPublishRideData

    var body: some View {
        VStack {
            if let data = publishRideData {
                VStack {
                    
                    VStack {
                        HStack {
                            Image(systemName: Constants.Icons.clock).foregroundColor(.blue)
                            Text(Helper().formatDateToMMM(data.date))
                            Spacer()
                            VStack {
                                Text(data.status).padding(12).font(.system(size: 12)).foregroundColor(.white)
                            }.background(data.status == "pending" ? Color.green : Color.red).cornerRadius(10)
                        }
                        
                        
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
                    }.padding()
                        .background {
                        Image("Background").resizable().cornerRadius(10).overlay {
                            TransparentBlurView(removeAllFilters: false).cornerRadius(10)
                        }
                    }
                 
                   
                    
             
                    VStack {
                        HStack {
                            HStack {
                                Image(systemName: Constants.Icons.person).foregroundColor(.blue)
                                Text(String(data.passengersCount)).foregroundColor(.white)
                            }
                            Spacer()
                            Text("Rs. \(data.setPrice)").bold().foregroundColor(.white)
                        }.padding(15)
                    }.background {
                            Image("download")
                                       .resizable()
                                       .mask(BottomCornerRadiusShape(cornerRadius: 10)).overlay {
                                TransparentBlurView(removeAllFilters: false).mask(BottomCornerRadiusShape(cornerRadius: 10))
                            }
                    }.padding(.top,-15)
                
                }

                
            } else {
                /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
            }
        }
    }
}

struct PublishedRideDetailCard_Previews: PreviewProvider {
    static var previews: some View {
        PublishedRideDetailCard(publishRideData: AllPublishRideData(id: 461, source: "Elante Mall", destination: "VRP Telematics Private Limited", passengersCount: 4, addCity: nil, date: "2023-06-29", time: "2000-01-01T04:38:00.000Z", setPrice: 2500, aboutRide: "Adas", userID: 221, createdAt: "2023-06-21T11:27:41.551Z", updatedAt: "2023-06-21T11:27:41.551Z", sourceLatitude: 30.70549299999999, sourceLongitude: 76.8012561, destinationLatitude: 28.5193495, destinationLongitude: 77.28101509999999, vehicleID: 243, bookInstantly: nil, midSeat: nil, selectRoute: nil, status: "pending", estimateTime: "2000-01-01T01:00:00.000Z", addCityLongitude: nil, addCityLatitude: nil))
    }
}


struct BottomCornerRadiusShape: Shape {
    let cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 90),
                    clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))
        path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 180),
                    clockwise: false)
        return path
    }
}
