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
    @State var isPublishView = false
    @EnvironmentObject var vm: MapAndSearchRideViewModel
    @StateObject var vehicleVm = RegisterVehicleViewModel()
    
    @State private var isDropdownVisible = false
    @State private var selectedVehicle: Datum?
    @State var selectedVehicleId: Int?
    @State var selection = 0
    
    var body: some View {
        
            VStack {
                VStack(spacing: 5) {
                    // MARK: Segmented Buttons
                    HStack {
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isPublishView = false
                                selection = 0
                            }
                        } label: {
                            Text("Search Ride")
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isPublishView = true
                                vehicleVm.isRegistering = false
                                vehicleVm.registerVehicle()
                                selection = 1
                            }
                        } label: {
                            Text("Publish Ride")
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.secondary)
                    
                    // MARK: Separator
                    Divider()
                        .background(.white.opacity(0.5))
                        .blendMode(.overlay)
                        .shadow(color: .black.opacity(0.2), radius: 0, x: 0, y: 1)
                        .blendMode(.overlay)
                        .overlay {
                            // MARK: Underline
                            HStack {
                                Divider()
                                    .frame(width: UIScreen.main.bounds.width / 2, height: 13)
                                    .background(Constants.Colors.underline) // Updated line
                                    .blendMode(.overlay)
                            }
                            .frame(maxWidth: .infinity, alignment: selection == 0 ? .leading : .trailing)
                            .offset(y: -1)
                        }
                }
                .padding(.top, 25)

                
                // MARK: - Start From
                Button {
                    showMapView.toggle()
                }label: {
                    HStack(spacing: 30) {
                        Image(systemName: Constants.Icons.circle).bold().padding(.leading).foregroundColor(.blue)
                        Text(vm.originData?.name.isEmpty ?? true ? "Start From" : vm.originData?.name ?? "Unknown").foregroundColor(.black)
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
                        Text(vm.destinationData?.name.isEmpty ?? true ? "Going to" : vm.destinationData?.name ?? "Unknown").foregroundColor(.black)
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
                            Text("\(selectedDate, formatter: DateFormatter.custom )").foregroundColor(.black) // Updated line
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
                        dateFormatter.dateFormat =  "yyyy-MM-dd"  // Updated line
                        vm.date = dateFormatter.string(from: selectedDate)
                    }

                    Divider().frame(height: 40).padding(.horizontal)
                    // MARK: - Seats
                    Button {
                        addSeatNavigate.toggle()
                    } label: {
                        HStack {
                            Image(systemName: Constants.Icons.person).font(.title2)
                            Text("\(vm.passengers)").font(.title2).foregroundColor(.black)
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
                        Image(systemName: "pencil").font(.title2).foregroundColor(.blue).padding(.leading).bold()
                        TextField("Write ride description here :", text: $vm.aboutRide).frame(height: 60).padding(.horizontal)
                    }
                    Divider().padding(.horizontal)
                    
                    HStack(spacing: 20) {
                        Image(systemName: "car.fill")
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
                                   Text(selectedVehicle == nil ? "Select your vehicle" : selectedVehicle?.vehicleBrand ?? "").foregroundColor(.black)
                                   Spacer()
                                   Image(systemName: Constants.Icons.rightChevron).foregroundColor(.gray)
                               }
                           }
                           .frame(height: 60)
        
                        
                        Spacer()
                    }
                    Divider()
    
                        HStack {
                            Image(systemName: "rupeesign").font(.title2).foregroundColor(.blue).padding(.leading).bold()
                            TextField("Enter amount ", text: $vm.amount).frame(height: 60).padding(.horizontal).keyboardType(.numberPad)
                        
                        }
                    
                   
                }
                
                
                
                // MARK: - Search
                Button {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "hh:mm a"

                    // Convert Date to String
                    vm.time = dateFormatter.string(from: currentDate)
                    
                    isPublishView ? vm.publishRide() : vm.searchRide()
                    isPublishView ? showCarPoolView = false :  showCarPoolView.toggle()
                    
                } label: {
                    HStack {
                        Spacer()
                        Text(isPublishView ? "Publish" : Constants.Labels.search).bold()
                        Spacer()
                    }.frame(height: 50).background(.blue).foregroundColor(.white)
                }.alert(isPresented: $vm.alertSuccess) {
                    Alert(title: Text("Success"), message: Text("Ride published successfully"), dismissButton: .default(Text("Ok")))
                }
                .disabled((vm.destinationData==nil && vm.originData == nil)).navigationDestination(isPresented: $showCarPoolView, destination: {
                    CarPoolView().transition(.opacity)
                })
            }.background(.white).cornerRadius(20).shadow(color: .gray, radius: 20)
        
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView().environmentObject(MapAndSearchRideViewModel())
    }
}
