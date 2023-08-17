//
//  PublishedRideDetailCard.swift
//  BlaBalApp
//
//  Created by ChicMic on 22/06/23.
//

import SwiftUI


struct PublishedRideDetailCard: View {
    var publishRideData: AllPublishRideData?
    var bookedRideData: AllBookedRideData?
    var indexValue: Int?
    @Binding var isPublishRideData: Bool
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            if let data = isPublishRideData ? publishRideData : bookedRideData?.ride {
                VStack {
                    HStack {
                        Image(systemName: Constants.Icons.clock).foregroundColor(.blue)
                        Text(Helper().formatDateToMMM(data.date, dateFormat: Constants.Date.stringToDateForamat))
                        Spacer()
                        VStack {
                            Text(data.status.capitalized).padding(10).padding(.horizontal).font(.system(size: 12))
                                .foregroundColor(Helper().colorSelector(status: data.status))
                        }
                        .background(Helper().colorSelector(status: data.status).opacity(0.1))
                        .cornerRadius(20, corners: [.topRight,.bottomLeft])
                        .padding(-15)
                        .padding(.top,-9)
                       
                        
                        
                    }
                    HStack(spacing: 20) {
                        if isPublishRideData {
                            DistanceCircleShowView(maxWidhth: 2, maxHeight: 35).padding(.leading)
                        } else {
                            VStack {
                                Image(systemName: Constants.Icons.circle).foregroundColor(.blue)
                                HStack {
                                    Divider().frame(height: 20)
                                }
                                Image(systemName: Constants.Icons.circle).foregroundColor(.blue)
                            }.padding(.leading)
                        }
                        
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
                    
                    Rectangle().frame(height: 2).foregroundColor(.gray).opacity(0.2)
                    
                    HStack {
                        HStack {
                            Image(systemName: Constants.Icons.seat).foregroundColor(.blue).bold()
                            Text(String(data.passengersCount))
                        }
                        if let bookedRideData = bookedRideData {
                            HStack {
                                Image(systemName: Constants.Icons.seat).foregroundColor(.blue).bold()
                                Text(String(bookedRideData.seat))
                            }
                        }
                        Spacer()
                        Text("Rs. \(data.setPrice)").bold()
                    }.padding(.horizontal,15)
                }.padding()
                .background {
                    Color.gray.opacity(0.15)
                        .cornerRadius(20)
                }
            } else {
                
                EmptyView()
            }
        }
    }
    
}

struct PublishedRideDetailCard_Previews: PreviewProvider {
    static var previews: some View {
        PublishedRideDetailCard(publishRideData: AllPublishRideData(id: 461, source: "Elante Mall", destination: "VRP Telematics Private Limited", passengersCount: 4, addCity: nil, date: "2023-06-29", time: "2000-01-01T04:38:00.000Z", setPrice: 2500, aboutRide: "Adas", userID: 221, createdAt: "2023-06-21T11:27:41.551Z", updatedAt: "2023-06-21T11:27:41.551Z", sourceLatitude: 30.70549299999999, sourceLongitude: 76.8012561, destinationLatitude: 28.5193495, destinationLongitude: 77.28101509999999, vehicleID: 243, bookInstantly: nil, midSeat: nil, selectRoute: nil, status: "pending", estimateTime: "2000-01-01T01:00:00.000Z", addCityLongitude: nil, addCityLatitude: nil), isPublishRideData: .constant(true))
    }
}
