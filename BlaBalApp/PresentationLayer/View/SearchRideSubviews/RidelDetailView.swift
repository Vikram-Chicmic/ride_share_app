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
    @EnvironmentObject var vehicleVm: RegisterVehicleViewModel
    @State var viewHeight: CGFloat = 0
    @State var secondViewHeight: CGFloat = 0
    @State var progressHeight: CGFloat = 0
    @State var navigateToBookRide = false
    @State var alertVerifyPhoneNumeber = false
    @EnvironmentObject var networkStatusManager: NetworkStatusManager
    var details: SearchRideResponseData
    @State var navigateToVerifyNumber = false
    @State var navigateToRiderDetail: Bool = false
    var body: some View {
                VStack(alignment: .leading) {
                        ScrollView {
                            VStack(alignment: .leading) {
                                Text("Overview").font(.title3).fontWeight(.semibold)
                                VStack(alignment: .leading, spacing: 30) {
                                    HStack {
                                        DistanceCircleShowView(maxWidhth: 3, maxHeight: 35)
                                        VStack(alignment: .leading, spacing: 30) {
                                            Text("\(details.publish.source)").font(.subheadline)
                                            Text("\(details.publish.destination)").font(.subheadline)

                                        }.padding(.horizontal)
                                        Spacer()
                                    }
                                 }.padding().background {
                                     Color(.gray).opacity(0.1).cornerRadius(10)
                                 }
                                Text("Details").font(.title3).fontWeight(.semibold).padding(.top)
                                VStack(spacing: 10) {
                                    RideDetailTileView(title: Constants.Texts.estTime, value: Helper().datetimeFormat(dateTime: details.publish.estimateTime, format: Constants.Date.timeFormat)).font(.subheadline)
                                    RideDetailTileView(title: Constants.Texts.passengers, value: String(details.publish.passengersCount)).font(.subheadline)
                                    RideDetailTileView(title: Constants.Texts.reachTime, value: Helper().formatDate(details.reachTime) ?? "").font(.subheadline)
                                    RideDetailTileView(title: Constants.Texts.ridestatus, value: details.publish.status).font(.subheadline)
                                    Divider().frame(height: 1).background(Color.gray)
                                    HStack {
                                        Text(Constants.Texts.totalPrice).font(.title2)
                                        Spacer()
                                        Text("Rs. \(details.publish.setPrice)").font(.title2).bold()
                                    }
                                }.padding().background {
                                    Color(.gray).opacity(0.1).cornerRadius(10)
                                }
                              
                    // MARK: - Vehicle Detail
                                VStack(alignment: .leading) {
                                    Text("Vehicle Details ").font(.title3).fontWeight(.semibold).padding(.top)
                                    VehicleDetailView(isComingFromPublishView: .constant(true)).padding(-15)
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
                                             case .failure:
                                                 // Show placeholder for failed image load
                                                 Image(systemName: Constants.Icons.perosncircle).resizable().frame(width: 80).clipShape(Circle()).scaledToFit()
                                             @unknown default:
                                                 fatalError("")
                                             }
                                         }
                                     } else {
                                         Image("Cathy").resizable().scaledToFit().frame(width: 80).clipShape(Circle()).scaledToFit()
                                     }
                                        
                                        Image(systemName: Constants.Icons.rightChevron)
                                    }.onTapGesture {
                                        vm.userId = details.id
                                        vm.apiCallForLoginSignUpViewModel(forMethod: .getUserById)
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
                                        Color(.gray).opacity(0.1).cornerRadius(10)
                                    }.padding(.vertical)
                                    
                                   
                                }
                            }
                        }.padding().scrollIndicators(.hidden).opacity(navigateToBookRide ? 0.5 : 1.0)
                    Button {
                        if ((vm.decodedData?.user.phoneVerified) != nil) {
                            navigateToBookRide.toggle()
                        } else {
                            alertVerifyPhoneNumeber.toggle()
                        }
                    } label: {
                        HStack {
                            Buttons(image: "", text: "Book Ride", color: Constants.Colors.bluecolor)
                        }.foregroundColor(.white)
                    }.padding()
                
                    .navigationDestination(isPresented: $navigateToBookRide) {
                        BookRide(details: details, dismissView: $navigateToBookRide)
                    }
                    Spacer()
                }.alert(isPresented: $alertVerifyPhoneNumeber, content: {
                    Alert(title: Text("Error"), message:  Text("Please verify your number first."), primaryButton: .default(Text("Verify now"),action: {
                        //navigate to number verification
                        navigateToVerifyNumber.toggle()
                    }), secondaryButton: .cancel(Text("Cancel")))
                    
                })
                .navigationDestination(isPresented: $navigateToVerifyNumber, destination: {
                    PhoneView()
                })
                .navigationBarTitle("Ride Details")
            .onAppear {

                    RegisterVehicleViewModel.shared.specificVehicleDetails = nil
                    RegisterVehicleViewModel.shared.getVehicleId = details.publish.vehicleID
                    RegisterVehicleViewModel.shared.apiCallForVehicles(method: .getVehicleDetailsById)
                
            }
            .overlay(
                VStack {
                    if vm.isLoading || vehicleVm.isLoading {
                        Spacer() // Push the ProgressView to the top
                        ProgressView().progressViewStyle(CircularProgressViewStyle())
                    }
                    Spacer() // Push the following content to the bottom
                    if vm.showToast || vehicleVm.showToast {
                        CustomAlert(text:vm.showToast ? vm.toastMessage : vehicleVm.toastMessage, dismiss: vm.showToast ? $vm.showToast : $vehicleVm.showToast)
                            .onAppear {
                                // Automatically hide the toast message after a delay
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    withAnimation {
                                        vm.showToast = false
                                        vehicleVm.showToast = false
                                    }
                                   
                                }
                            }
                         
                            .animation(.default)
                    }
                }
            )
            
        
    }
}

struct CarPoolDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RideDetailView(details: SearchRideResponseData(id: 256, name: "Hriday", reachTime: "2023-06-15T11:14:58.000Z", imageURL: nil, averageRating: nil, aboutRide: "", publish: BlaBalApp.Publish(id: 373, source: "Business & Industrial Park 1, Chandigarh", destination: "Sector 118, Mohali", passengersCount: 1, addCity: nil, date: "2023-06-15", time: "2000-01-01T10:41:00.000Z", setPrice: 200, aboutRide: "", userID: 256, createdAt: "2023-06-12T05:12:43.252Z", updatedAt: "2023-06-12T06:42:49.717Z", sourceLatitude: 30.704758007382228, sourceLongitude: 76.801208, destinationLatitude: 30.737185, destinationLongitude: 76.678551, vehicleID: 218, bookInstantly: nil, midSeat: nil, selectRoute: BlaBalApp.SelectRoute(), status: "pending", estimateTime: "2000-01-01T00:33:58.000Z", addCityLongitude: nil, addCityLatitude: nil, distance: 0.08185672694379517, bearing: "183.744259068662"))).environmentObject(LoginSignUpViewModel())
    }
}
