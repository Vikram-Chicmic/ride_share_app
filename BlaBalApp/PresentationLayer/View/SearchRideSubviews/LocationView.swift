//
//  LocationView.swift
//  BlaBalApp
//
//  Created by ChicMic on 10/05/23.
//

import SwiftUI

struct LocationView: View {

    @State var addSeatNavigate: Bool = false
    @State var seats: Int = 1
    @State var openCalendar: Bool = false
    @State private var selectedDate = Date()
    @State private var currentDate = Date()
    @State var showMapView = false
    @State var showCarPoolView = false
    @State var isOrigin = true
    @Binding var isPublishView: Bool
    @EnvironmentObject var vm: MapAndSearchRideViewModel
    @EnvironmentObject var vehicleVm: RegisterVehicleViewModel
    @State private var isDropdownVisible = false
    @State private var selectedVehicle: Datum?
    @State var selectedVehicleId: Int?
    @State var selection = 0
    @FocusState var isFocused: Bool
    @State var showMap = false
    @Binding var isComingFromPublishedView: Bool
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
            VStack {
                
                VStack {
                    if isComingFromPublishedView {
                        VStack {
                            Text("Update Ride")
                            UnderlineView().frame(width: 150)
                        }.padding(.top)
                    } else {
                        VStack(spacing: 5) {
                            // MARK: Segmented Buttons
                            HStack {
                                VStack {
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            isPublishView = false
                                        }
                                    } label: {
                                        Text(Constants.Buttons.searchRide)
                                        
                                      
                                    }
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    if !isPublishView { UnderlineView().padding(.horizontal) }
                                }
                               
                                VStack {
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            isPublishView = true
                                            vehicleVm.isRegistering = false
                                            vehicleVm.apiCall(method: .getVehicle)
                                        }
                                    } label: {
                                        Text(Constants.Buttons.publishRide)
                                    }
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    if isPublishView { UnderlineView().padding(.horizontal) }
                                }
                                
                            }
                            .font(.subheadline.weight(.semibold))
                            .foregroundColor(.secondary)
                        }
                        .padding(.top, 25)
                    }

                    
                    // MARK: - Start From
                    Button {
                        showMapView.toggle()
                    }label: {
                        HStack(spacing: 30) {
                            Image(systemName: Constants.Icons.circle).bold().padding(.leading).foregroundColor(.blue)
                            Text(vm.originData?.name.isEmpty ?? true ? Constants.DefaultValues.start : vm.originData?.name ?? Constants.DefaultValues.unknown).foregroundColor(colorScheme == .dark ? .white : .black)
                            Spacer()
                        }
                    }.sheet(isPresented: $showMapView, content: {
                        MapView( isOrigin: $isOrigin)
                    })
                    .padding(.top, 4)
                    .frame(height: 45)
                    Divider().padding(.horizontal)


                    // MARK: - Going to
                    Button {
                        isOrigin = false
                        showMapView.toggle()
                        } label: {
                        HStack(spacing: 30) {
                            Image(systemName: Constants.Icons.location).bold().padding(.leading).foregroundColor(.blue)
                            Text(vm.destinationData?.name.isEmpty ?? true ? Constants.DefaultValues.dest : vm.destinationData?.name ?? Constants.DefaultValues.unknown).foregroundColor(colorScheme == .dark ? .white : .black)
                            Spacer()
                        }
                    }
                    .sheet(isPresented: $showMapView, content: {
                        MapView( isOrigin: $isOrigin)
                    })
                    .frame(height: 40)
                    Divider().padding(.horizontal)
                    // MARK: - Calendar
                    HStack {
                        Button {
                            openCalendar = true
                        } label: {
                            HStack(spacing: 20) {
                                Image(systemName: Constants.Icons.calander).font(.title2).padding(.leading)
                                Text("\(selectedDate, formatter: DateFormatter.custom )").foregroundColor(colorScheme == .dark ? .white : .black) // Updated line
                                Spacer()
                            }
                            .padding(.trailing, 10)
                            .frame(height: 40)
                        }
                        .sheet(isPresented: $openCalendar) {
                            CalendarView(selectedDate: $selectedDate, isDob: .constant(false))
                        }
                        .onChange(of: selectedDate) { _ in
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat =  Constants.Date.dateFormat  // Updated line
                            vm.date = dateFormatter.string(from: selectedDate)
                        }

                        Divider().frame(height: 40).padding(.horizontal)
                        // MARK: - Seats
                        Button {
                            addSeatNavigate.toggle()
                        } label: {
                            HStack {
                                Image(systemName: Constants.Icons.person).font(.title2)
                                Text("\(vm.passengers)").font(.title2).foregroundColor(colorScheme == .dark ? .white : .black)
                            }
                        }.padding(.trailing, 40)
                    }.sheet(isPresented: $addSeatNavigate) {
                        AddSeatView(seat: $vm.passengers, temp: seats, isPublishView: $isPublishView)
                    }
                    
                    
                    if isPublishView {
                        Divider().padding(.horizontal)
                        
                        // MARK: Time
                        HStack {
                            Image(systemName: Constants.Icons.clock).font(.title2).foregroundColor(.blue).padding(.leading).bold()
                            VStack {
                                      DatePicker("", selection: $currentDate, displayedComponents: .hourAndMinute)
                                      .labelsHidden()
                            }.padding(.horizontal)
                            Spacer()
                        }.frame(height: 50)
                        
                        Divider().padding(.horizontal)
                        
                        HStack {
                            Image(systemName: Constants.Icons.pencil).font(.title2).foregroundColor(.blue).padding(.leading).bold()
                            TextField(Constants.Placeholders.description, text: $vm.aboutRide).frame(height: 60).padding(.horizontal).focused($isFocused)
                            
                            Divider().frame(height: 20)
                            
                            
                        }
                        Divider().padding(.horizontal)
                        
                        
                        HStack(spacing: 20) {
                            Image(systemName: Constants.Icons.carfill)
                                .font(.title2)
                                .foregroundColor(.blue)
                                .padding(.leading)
                                .bold()
                            
                            Menu {
                                   if let data = vehicleVm.decodedVehicleData?.data {
                                       ForEach(data.indices, id: \.self) { index in
                                           Button {
                                               selectedVehicle = data[index]
                                               vm.vehicleId = data[index].id
                                           } label: {
                                               Text("\(data[index].vehicleBrand)")
                                           }
                                       }
                                   }
                               } label: {
                                   HStack {
                                       Text(selectedVehicle == nil ? Constants.DefaultValues.selectVehicle : selectedVehicle?.vehicleBrand ?? "").foregroundColor(colorScheme == .dark ? .white : .black)
                                       Spacer()
                                       Image(systemName: Constants.Icons.rightChevron).foregroundColor(.gray)
                                   }
                               }
                               .frame(height: 60)
            
                            Divider().frame(height: 40)
                            
                            Button {
                                vm.apiCall(for: .fetchPolylineAndDistanceOfRide)
                                self.showMap.toggle()
                            } label: {
                                HStack{
                                    Text("Open map").padding()
                                    Image(systemName: Constants.Icons.rightChevron)
                                }.padding(.horizontal)
                            }
                            Spacer()
                        }.navigationDestination(isPresented: $showMap) {
                            ShowPolylineView()
                        }
                        
                        Divider()
        
                            HStack {
                                Image(systemName: Constants.Icons.rupeeSign).font(.title2).foregroundColor(.blue).padding(.leading).bold()
                                TextField(Constants.Placeholders.enterAmount, text: $vm.amount).frame(height: 60).padding(.horizontal).keyboardType(.numberPad).focused($isFocused)
                            
                            }
                        
                       
                    }
                    
                }.background {
                    Image("Background")
                        .resizable()
                        .scaledToFill()
                               .mask(BottomCornerRadiusShape(cornerRadius: 10)).overlay {
                        TransparentBlurView(removeAllFilters: false).mask(BottomCornerRadiusShape(cornerRadius: 10))
                    }
                }
                
                
                // MARK: - Search
                Button {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = Constants.Date.timeFormat

                    // Convert Date to String
                    vm.time = dateFormatter.string(from: currentDate)
                    vm.apiCall(for: .fetchPolylineAndDistanceOfRide )
                    if isComingFromPublishedView {
                        vm.apiCall(for: .updateRide)
                    } else {
                        
                        isPublishView ? vm.apiCall(for: .publishRide) : vm.apiCall(for: .searchRide)
                        isPublishView ? showCarPoolView = false :  showCarPoolView.toggle()
                    }
                  
                    
                } label: {
                    
                    
                    HStack {
                        Spacer()
                        Text(isPublishView ? Constants.DefaultValues.publish : Constants.Labels.search).bold()
                        Spacer()
                    }.frame(height: 50)
                        .background {
                            Image("download")
                                       .resizable()
                                       .mask(BottomCornerRadiusShape(cornerRadius: 10)).overlay {
                                TransparentBlurView(removeAllFilters: false).mask(BottomCornerRadiusShape(cornerRadius: 10))
                            }
                        }.foregroundColor(.white)
                }.padding(.top,-10).alert(isPresented: $vm.alertSuccess) {
                    Alert(title: Text(Constants.Alert.success), message: Text(Constants.Alert.ridePublishSuccess), dismissButton: .default(Text(Constants.Buttons.ok), action: {
                       
                    }))
                  
                }
                .disabled((vm.destinationData==nil && vm.originData == nil)).navigationDestination(isPresented: $showCarPoolView, destination: {
//                    CarPoolView().transition(.opacity)
                })
       
                
                
               
                
            }.onTapGesture {
                self.isFocused = false
            }.background(.white).cornerRadius(20)
        
    }
   
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(isPublishView: .constant(true), isComingFromPublishedView: .constant(true))
            .environmentObject(RegisterVehicleViewModel()).environmentObject(MapAndSearchRideViewModel())
    }
}
