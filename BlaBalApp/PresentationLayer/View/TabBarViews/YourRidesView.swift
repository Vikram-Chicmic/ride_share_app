//
//  YourRidesView.swift
//  BlaBalApp
//
//  Created by ChicMic on 11/05/23.
//

import SwiftUI

struct YourRidesView: View {
    @EnvironmentObject var vm: MapAndSearchRideViewModel
    @State var isPublishRidesView = true
    @State var selectedCardData: AllPublishRideData?
    @State var navigateToDetail = false
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
                                        self.selectedCardData = data[index]
                                        navigateToDetail.toggle()
                                    }
                            }.padding().padding(.bottom, 20)
                            
                        } else {
                            VStack {
                                                        Image("carsaf").resizable().scaledToFit().frame(width: 300)
                                                        Text("No rides found").foregroundColor(.blue).font(.title).bold()
                            }.background {
                                Image("download").overlay {
                                    TransparentBlurView(removeAllFilters: false)
                                }
                            }
                        }
                    }
                }.refreshable {
                    vm.apiCall(for: .getAllPublisghRideOfCurrentUser)
                }.scrollIndicators(.hidden)
                    .navigationDestination(isPresented: $navigateToDetail) {
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
                                        self.selectedCardData = data[index].ride
                                        vm.passengerId = data[index].bookingID
                                        indexValue = index
                                        navigateToDetail.toggle()
                                    }
                            }.padding().padding(.bottom, 20)
                            
                        } else {
                            VStack {
                                                        Image("carsaf").resizable().scaledToFit().frame(width: 300)
                                                        Text("No rides found").foregroundColor(.blue).font(.title).bold()
                            }.background {
                                Image("download").overlay {
                                    TransparentBlurView(removeAllFilters: false)
                                }
                            }
                        }
                    }
                }.scrollIndicators(.hidden).refreshable {
                    vm.apiCall(for: .getAllBookedRideOfCurentUser)
                }
                    .navigationDestination(isPresented: $navigateToDetail) {
                        if let data = selectedCardData{
                            PublishedRideDetailView(selectedCardData: data, isPublishedRide: $isPublishRidesView, indexValue: indexValue)
                        }
                        
                    }
            }

            
            
            
          Spacer()
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            if vm.allPublishRides?.count == 0 {
                VStack {
                    Image(Constants.Images.travel).resizable().scaledToFit()
                    Text(Constants.Header.travel).font(.title).fontWeight(.semibold).padding(.trailing).padding(.vertical)
                    Text(Constants.Texts.travel).foregroundColor(.gray).padding(.trailing)
                    Spacer()
                }.padding(.horizontal)
            }
        }.onAppear {
            vm.apiCall(for: .getAllPublisghRideOfCurrentUser)
            RegisterVehicleViewModel.shared.apiCall(method: .getVehicle)
        }
    }
}

struct YourRidesView_Previews: PreviewProvider {
    static var previews: some View {
        YourRidesView().environmentObject(MapAndSearchRideViewModel())
    }
}
