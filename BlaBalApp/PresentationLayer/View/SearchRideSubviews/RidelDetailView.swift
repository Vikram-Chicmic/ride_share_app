//
//  CarPoolDetailView.swift
//  BlaBalApp
//
//  Created by ChicMic on 26/05/23.
//

import SwiftUI

struct RideDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: LoginSignUpViewModel
    @State var viewHeight: CGFloat = 0
    @State var secondViewHeight: CGFloat = 0
    @State var progressHeight: CGFloat = 0
    @State var navigateToBookRide = false
    var details: SearchRideResponseData
    @State var navigateToRiderDetail: Bool = false
    var body: some View {
                VStack(alignment: .leading) {
                        ScrollView {
                            VStack(alignment: .leading) {
                                VStack(alignment: .leading, spacing: 30) {
                                    HStack {
                                        DistanceCircleShowView(maxWidhth: 3, maxHeight: 35)
                                        
                                        VStack(alignment: .leading, spacing: 30){
                                            Text("\(details.publish.source)").bold()
                                            Text("\(details.publish.destination)").bold()

                                        }.padding(.horizontal)
                                        Spacer()
                                    }
                                            
                                 }.padding().background {
                                     Image("Bank").resizable().cornerRadius(10).overlay {
                                         TransparentBlurView(removeAllFilters: false).cornerRadius(10)
                                     }
                                 }

                                
                                Text("Details").font(.title3).fontWeight(.semibold).padding(.top)
                                VStack(spacing: 10) {
                                    RideDetailTileView(title: Constants.Texts.estTime, value: Helper().estimatedTimeFormatter(date: details.publish.estimateTime))
                                    RideDetailTileView(title: Constants.Texts.passengers, value: String(details.publish.passengersCount))
                                    RideDetailTileView(title: Constants.Texts.reachTime, value: Helper().formatDate(details.reachTime) ?? "")
                                    RideDetailTileView(title: Constants.Texts.ridestatus, value: details.publish.status)
                                    Divider().frame(height: 1).background(Color.gray)
                                    HStack {
                                        Text(Constants.Texts.totalPrice).font(.title2)
                                        Spacer()
                                        Text("Rs. \(details.publish.setPrice)").font(.title2).bold()
                                    }
                                }.padding().background {
                                    Image("Bank").resizable().cornerRadius(10).overlay {
                                        TransparentBlurView(removeAllFilters: false).cornerRadius(10)
                                    }
                                }
                              
                    
                                
                                VStack {
                                  
                                    
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(details.name).font(.title3)
                                            HStack {

                                                
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
                                        
                                        Image(systemName: Constants.Icons.rightChevron)
                                    }.onTapGesture {
                                        vm.userId = details.id
                                        vm.apiCall(forMethod: .getUserById)
                                        navigateToRiderDetail.toggle()
                                    }
                                    .navigationDestination(isPresented: $navigateToRiderDetail, destination: {
                                        if let data = vm.decodedData {
                                            DriverDetailView(data: data)
                                        } else {
                                            // show popup unable to fetch user details
                                        }
                                      
                                    })
                                    .frame(height: 50).padding().background {
                                        Image("Bank").resizable().opacity(0.4).cornerRadius(10).overlay {
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
                                    .navigationDestination(isPresented: $navigateToBookRide) {
                                        BookRide(details: details, dismissView: $navigateToBookRide)
                                    }
                                }
                            }
                        }.padding().scrollIndicators(.hidden).opacity(navigateToBookRide ? 0.5 : 1.0)
                        
//
//                        if navigateToBookRide {
//                            BookRide(details: details, dismissView: $navigateToBookRide)
//                        }
                        
                        
                    
                    Spacer()
                }.navigationBarTitle("Ride Details")
            
        
    }
}

struct CarPoolDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RideDetailView(details: SearchRideResponseData(id: 256, name: "Hriday", reachTime: "2023-06-15T11:14:58.000Z", imageURL: nil, averageRating: nil, aboutRide: "", publish: BlaBalApp.Publish(id: 373, source: "Business & Industrial Park 1, Chandigarh", destination: "Sector 118, Mohali", passengersCount: 1, addCity: nil, date: "2023-06-15", time: "2000-01-01T10:41:00.000Z", setPrice: 200, aboutRide: "", userID: 256, createdAt: "2023-06-12T05:12:43.252Z", updatedAt: "2023-06-12T06:42:49.717Z", sourceLatitude: 30.704758007382228, sourceLongitude: 76.801208, destinationLatitude: 30.737185, destinationLongitude: 76.678551, vehicleID: 218, bookInstantly: nil, midSeat: nil, selectRoute: BlaBalApp.SelectRoute(), status: "pending", estimateTime: "2000-01-01T00:33:58.000Z", addCityLongitude: nil, addCityLatitude: nil, distance: 0.08185672694379517, bearing: "183.744259068662")))
    }
}
