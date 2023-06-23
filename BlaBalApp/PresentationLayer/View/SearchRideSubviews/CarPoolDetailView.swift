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
                  
                  
                    ZStack {
                        ScrollView {
                            VStack(alignment: .leading) {
                                VStack(alignment: .leading, spacing: 30) {
                                     HStack {
                                         Image(systemName: Constants.Icons.circle).foregroundColor(.blue).padding()
                                         VStack(alignment: .leading) {
                                             Text(Helper().formatDate(details.publish.date) ?? "").font(.subheadline)
                                             Text("\(details.publish.source)").bold()
                                         }
                                         Spacer()
                                     }
                                    HStack {
                                        Image(systemName: Constants.Icons.circle).foregroundColor(.blue).padding()
                                        VStack(alignment: .leading) {
                                            Text(Helper().formatDate(details.reachTime) ?? "").font(.subheadline)
                                            Text("\(details.publish.destination)").bold()
                                        }
                                        Spacer()
                                    }
                                 
                                  
                                 }.padding().background {
                                     Image("Background").resizable().cornerRadius(10).overlay {
                                         TransparentBlurView(removeAllFilters: false).cornerRadius(10)
                                     }
                                 }

                                Divider()
                                
                                Text("Details").font(.title3).fontWeight(.semibold).padding(.top)
                                VStack(spacing: 10) {
                                    RideDetailTileView(title: Constants.Texts.deptTime, value: Helper().formatDate(details.publish.time) ?? "")
                                    RideDetailTileView(title: Constants.Texts.estTime, value: details.publish.estimateTime)
                                    RideDetailTileView(title: Constants.Texts.passengers, value: String(details.publish.passengersCount))
                                    RideDetailTileView(title: Constants.Texts.reachTime, value: Helper().formatDate(details.reachTime) ?? "")
                                    RideDetailTileView(title: Constants.Texts.ridestatus, value: details.publish.status)
                                }.padding().background {
                                    Image("Background").resizable().cornerRadius(10).overlay {
                                        TransparentBlurView(removeAllFilters: false).cornerRadius(10)
                                    }
                                }
                                HStack {
                                    Text(Constants.Texts.totalPrice)
                                    Spacer()
                                    Text("Rs. \(details.publish.setPrice)").font(.title2).bold()
                                }.padding(.horizontal).padding().background {
                                    Image("download").resizable().cornerRadius(10).overlay {
                                        TransparentBlurView(removeAllFilters: false).cornerRadius(10)
                                    }
                                }.padding(.top, -19)
                    
                                
                                VStack {
                                  
                                    
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
                                        if let imageURL = URL(string: details.imageURL ?? "") {
                                         AsyncImage(url: imageURL) { phase in
                                             switch phase {
                                             case .empty:
                                                 ProgressView()
                                                     .progressViewStyle(CircularProgressViewStyle())
                                             case .success(let image):
                                                 image.resizable().frame(width: 80).clipShape(Circle()).scaledToFit()
                                             case .failure(_):
                                                 // Show placeholder for failed image load
                                                 Image(systemName: Constants.Icons.perosncircle).resizable().frame(width: 80).clipShape(Circle()).scaledToFit()
                                             }
                                         }
                                     } else {
                                         Image(systemName: Constants.Icons.perosncircle).resizable().frame(width: 80).clipShape(Circle()).scaledToFit()
                                     }
                                        
    //                                    Image(URL(ur: details.imageURL)).resizable().frame(width: 50).clipShape(Circle()).scaledToFit()
                                    }.frame(height: 100).padding().background {
                                        Image("Background").resizable().cornerRadius(10).overlay {
                                            TransparentBlurView(removeAllFilters: false).cornerRadius(10)
                                        }
                                    }.padding(.vertical)
                                    
                                    Button {
                                        navigateToBookRide.toggle()
                                    } label: {
                                        HStack {
                                            Spacer()
                                            Text(Constants.Buttons.bookRide).font(.title3).bold()
                                            Spacer()
                                        }.foregroundColor(.white)
                                    }.padding(.vertical).background {
                                        Image("download").resizable().cornerRadius(10).overlay {
                                            TransparentBlurView(removeAllFilters: false).cornerRadius(10)
                                        }
                                    }
//                                    .navigationDestination(isPresented: $navigateToBookRide) {
//                                        BookRide(details: details)
//                                    }
                                }
                            }
                        }.scrollIndicators(.hidden).opacity(navigateToBookRide ? 0.5 : 1.0)
                        
                        
                        if navigateToBookRide {
                            BookRide(details: details, dismissView: $navigateToBookRide)
                        }
                        
                        
                    }
                    Spacer()
                }.navigationBarBackButtonHidden(true).padding()
            
        
    }
}

struct CarPoolDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CarPoolDetailView(details: SearchRideResponseData(id: 256, name: "Hriday", reachTime: "2023-06-15T11:14:58.000Z", imageURL: nil, averageRating: nil, aboutRide: "", publish: BlaBalApp.Publish(id: 373, source: "Business & Industrial Park 1, Chandigarh", destination: "Sector 118, Mohali", passengersCount: 1, addCity: nil, date: "2023-06-15", time: "2000-01-01T10:41:00.000Z", setPrice: 200, aboutRide: "", userID: 256, createdAt: "2023-06-12T05:12:43.252Z", updatedAt: "2023-06-12T06:42:49.717Z", sourceLatitude: 30.704758007382228, sourceLongitude: 76.801208, destinationLatitude: 30.737185, destinationLongitude: 76.678551, vehicleID: 218, bookInstantly: nil, midSeat: nil, selectRoute: BlaBalApp.SelectRoute(), status: "pending", estimateTime: "2000-01-01T00:33:58.000Z", addCityLongitude: nil, addCityLatitude: nil, distance: 0.08185672694379517, bearing: "183.744259068662")))
    }
}
