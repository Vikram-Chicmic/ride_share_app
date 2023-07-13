//
//  YourRidesView.swift
//  BlaBalApp
//
//  Created by ChicMic on 11/05/23.
//

import SwiftUI

struct YourRidesView: View {
    @EnvironmentObject var vm: MapAndSearchRideViewModel
    @EnvironmentObject var vmm: LoginSignUpViewModel
    @State var isPublishRidesView = true
    @State var selectedCardData: AllPublishRideData?
    
    @EnvironmentObject var vehicleVm: RegisterVehicleViewModel
    @State var indexValue : Int = 0
    var body: some View {
        VStack {
            VStack(spacing: 5) {
                // MARK: Segmented Buttons
                HStack {
                    VStack {
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isPublishRidesView = true
                                vm.apiCall(for: .getAllPublisghRideOfCurrentUser)
                            }
                        } label: {
                            Text(Constants.Buttons.publisdedRides)
                            
                          
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        if isPublishRidesView { UnderlineView().padding(.horizontal) }
                    }
                   
                    
                    //
                    VStack {
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isPublishRidesView = false
                                vm.apiCall(for: .getAllBookedRideOfCurentUser)
                            }
                        } label: {
                            Text(Constants.Buttons.bookedRides)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        if !isPublishRidesView { UnderlineView().padding(.horizontal) }
                    }
                    
                }
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.secondary)
            }
            .padding(.top, 25)
            
            if isPublishRidesView {
                ScrollView {
                    if let data = vm.allPublishRides {
                        if data.count > 0 {
                            ForEach(data.indices, id: \.self) { index in
                                PublishedRideDetailCard(publishRideData: data[index], isPublishRideData: $isPublishRidesView)
                                    .onTapGesture {
//                                        if data[index].status != "cancelled" {
                                            self.selectedCardData = data[index]
                                            vehicleVm.getVehicleId = data[index].vehicleID
                                            vehicleVm.apiCall(method: .getVehicleDetailsById)
//                                        }
                                      
                                    }
                            }.padding().padding(.bottom, 20)
                            
                        } else {
                            VStack {
                                Image(Constants.Images.travel).resizable().scaledToFit()
                                Text(Constants.Header.travel).font(.title).fontWeight(.semibold).padding(.trailing).padding(.vertical)
                                Text(Constants.Texts.travel).foregroundColor(.gray).padding(.trailing)
                                Spacer()
                            }.padding(.horizontal)
                        }
                    }
                }.onAppear {
                    vm.isLoading = true
                }.overlay(content: {
                    if vm.isLoading == true {
                        ProgressView().progressViewStyle(.circular)
                    }
                })
                .padding(.bottom,10)
                .refreshable {
                    vm.apiCall(for: .getAllPublisghRideOfCurrentUser)
                }
                .scrollIndicators(.hidden)
                .alert(isPresented: $vm.alertFetchPublishedRideFailure) {
                    Alert(title: Text(Constants.Alert.error),
                          message: Text(ErrorAlert.fetchPublishedRide.rawValue),
                          dismissButton: .cancel(Text(Constants.Buttons.ok)))
                }
                .navigationDestination(isPresented: $vehicleVm.navigateToDetail) {
                        if let data = selectedCardData {
                            PublishedRideDetailView(selectedCardData: data, isPublishedRide: $isPublishRidesView)
                        }
                       
                    }
            }
            else {
                ScrollView {
                    if let data =  vm.allBookedRides?.rides {
                        if data.count > 0 {
                            ForEach(data.indices, id: \.self) { index in
                                PublishedRideDetailCard(bookedRideData: data[index], indexValue: indexValue, isPublishRideData: $isPublishRidesView)
                                    .onTapGesture {
//                                        if data[index].status != "cancel booking" {
                                            self.selectedCardData = data[index].ride
                                            vmm.userId = data[index].ride.userID
                                            vm.passengerId = data[index].bookingID
                                            indexValue = index
                                            vehicleVm.getVehicleId = data[index].ride.vehicleID
                                            vehicleVm.apiCall(method: .getVehicleDetailsById)
                                            vmm.apiCall(forMethod: .getUserById)
//                                        }
                                      
                                    }
                            }.padding().padding(.bottom, 20)
                            
                        } else {
                            VStack {
                                Image(Constants.Images.travel).resizable().scaledToFit()
                                Text(Constants.Header.travel).font(.title).fontWeight(.semibold).padding(.trailing).padding(.vertical)
                                Text(Constants.Texts.travel).foregroundColor(.gray).padding(.trailing)
                                Spacer()
                            }.padding(.horizontal)
                        }
                    }
                }.onAppear {
                    vm.isLoading = true
                }.overlay(content: {
                    if vm.isLoading == true {
                        ProgressView().progressViewStyle(.circular)
                    }
                }).padding(.bottom, 10).scrollIndicators(.hidden).refreshable {
                    vm.apiCall(for: .getAllBookedRideOfCurentUser)
                }.alert(isPresented: $vm.alertFetchBookedRideFailure) {
                    Alert(title: Text(Constants.Alert.error),
                          message: Text(ErrorAlert.fetchBookedRide.rawValue),
                          dismissButton: .cancel(Text(Constants.Buttons.ok)))
            }
                .navigationDestination(isPresented: $vehicleVm.navigateToDetail) {
                        if let data = selectedCardData{
                            PublishedRideDetailView(selectedCardData: data, isPublishedRide: $isPublishRidesView, indexValue: indexValue)
                        }
                        
                    }
            }
        }
         .onAppear {
            vm.apiCall(for: .getAllPublisghRideOfCurrentUser)
             vm.apiCall(for: .getAllBookedRideOfCurentUser)
//            RegisterVehicleViewModel.shared.apiCall(method: .getVehicle)
        }
    }
}

struct YourRidesView_Previews: PreviewProvider {
    static var previews: some View {
        YourRidesView().environmentObject(MapAndSearchRideViewModel())
    }
}
