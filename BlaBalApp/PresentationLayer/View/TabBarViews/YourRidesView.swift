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
    var body: some View {
        VStack {
            VStack(spacing: 5) {
                // MARK: Segmented Buttons
                HStack {
                    VStack {
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isPublishRidesView = true
                                vm.apiCall(for: .getAllRidePublisghRideOfCurrentUser)
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
                                PublishedRideDetailCard(publishRideData: data[index])
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
                }.scrollIndicators(.hidden)
                    .navigationDestination(isPresented: $navigateToDetail) {
                        if let data = selectedCardData {
                           PublishedRideDetailView(selectedCardData: data)
                        }
                       
                    }
            }
            else {
                
            }
            
//            ScrollView {
//                if let data = vm.allPublishRides {
//                    if data.count > 0 {
//                        ForEach(data.indices, id: \.self) { index in
//                            CarPoolCard(data: data[index])
//                                .onTapGesture {
//                                    self.selectedCardData = data[index]
//                                    navigateToDetail.toggle()
//                                }
//                        }.navigationDestination(isPresented: $navigate, destination: {
//                            if let data = selectedCardData {
//                                CarPoolDetailView(details: data)
//                            }
//                        }).scrollIndicators(.hidden).padding()
//                    } else {
//                        VStack {
//                            Image("carsaf").resizable().scaledToFit().frame(width: 300)
//                            Text("No rides found").foregroundColor(.blue).font(.title).bold()
//                        }
//                    }
//                }
//            }
            
            
            
            
            
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
            vm.apiCall(for: .getAllRidePublisghRideOfCurrentUser)
            RegisterVehicleViewModel.shared.apiCall(method: .getVehicle)
        }
    }
}

struct YourRidesView_Previews: PreviewProvider {
    static var previews: some View {
        YourRidesView().environmentObject(MapAndSearchRideViewModel())
    }
}
