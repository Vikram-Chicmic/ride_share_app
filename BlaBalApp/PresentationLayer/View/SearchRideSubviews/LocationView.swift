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
    @State var newSelectedDate: Date? = Date()

    @EnvironmentObject var vm: MapAndRidesViewModel
    @EnvironmentObject var vehicleVm: RegisterVehicleViewModel
    @EnvironmentObject var baseApi: BaseApiManager
    @State private var isDropdownVisible = false
    @State private var selectedVehicle: Datum?
    @State var selectedVehicleId: Int?
    @State var selection = 0
    @FocusState var isFocused: Bool
    @State var showMap = false
    @Binding var isComingFromPublishedView: Bool
    @State var openTimePicker = false
    @State var vehicleIndex: Int = 0
    @State var vehicleName: String?
    @Binding var showAlert: Bool
    @Environment(\.colorScheme) var colorScheme
    let minDate = Calendar.current.date(from: DateComponents(year: 1940, month: 1, day: 1))!
    let maxDate = Date()
    @State var isDisable: Bool = true
    
    var body: some View {
        
        VStack {
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
                                            HStack {
                                             Spacer()
                                                Text(Constants.Buttons.searchRide)
                                                Spacer()
                                            }
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
                                            HStack {
                                                Spacer()
                                                Text(Constants.Buttons.publishRide)
                                                Spacer()
                                            }
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
                            MapSearchView( isOrigin: $isOrigin)
                        })
                        .frame(height: 45)
                        Rectangle().frame(height: 2).foregroundColor(.gray.opacity(0.2)).padding(.horizontal)


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
                            MapSearchView( isOrigin: $isOrigin)
                        })
                        .frame(height: 40)
                        
                        Rectangle().frame(height: 2).foregroundColor(.gray.opacity(0.2)).padding(.horizontal)
                       
                        
                        // MARK: - Calendar
                        HStack {
                            HStack(spacing: 20) {
                                Image(systemName: Constants.Icons.calander).padding(.leading).foregroundColor(.blue)
                                DatePickerTextField(placeholder: "", date: $newSelectedDate, pickerType: PickerType.date).padding(.leading, 8)
                                Spacer()
                            }
                                .padding(.trailing, 10)
                                .frame(height: 40)
                       
                            HStack {
                                Rectangle().frame(width: 2).foregroundColor(.gray.opacity(0.2)).padding(.horizontal)
                            }
                            
                            // MARK: - Seats
                                Button {
                                    addSeatNavigate.toggle()
                                } label: {
                                    HStack {
                                        Image(systemName: Constants.Icons.person).bold()
                                        Text("\(vm.passengers)").font(.title2).foregroundColor(colorScheme == .dark ? .white : .black)
                                    }
                                }.padding(.trailing, 40)
                            .sheet(isPresented: $addSeatNavigate) {
                                AddSeatView(seat: $vm.passengers, temp: seats, isPublishView: $isPublishView)
                            }
                        }.frame(height: 40)
                     
                        
                        if isPublishView {
                            
                            Rectangle().frame(height: 2).foregroundColor(.gray.opacity(0.2)).padding(.horizontal)
                            // MARK: - Time
                            HStack {
                                Image(systemName: Constants.Icons.clock).foregroundColor(.blue).padding(.leading).bold()
                                DatePickerTextField(placeholder: "", date: $newSelectedDate, pickerType: PickerType.time).padding(.leading)
                                Spacer()
                            }.frame(height: 40)
                            
                            Rectangle().frame(height: 2).foregroundColor(.gray.opacity(0.2)).padding(.horizontal)
                            
                            
                            
                            // MARK: - Discription
                            HStack {
                                Image(systemName: Constants.Icons.pencil).foregroundColor(.blue).padding(.leading).bold()
                                TextField(Constants.Placeholders.description, text: $vm.aboutRide).frame(height: 50).padding(.horizontal).focused($isFocused)
                               
                            }
                            Rectangle().frame(height: 2).foregroundColor(.gray.opacity(0.2)).padding(.horizontal)
                            
                        
                            //MARK: - Vehicle Selection
                            HStack {
                                Image(systemName: Constants.Icons.carfill)
                                    .foregroundColor(.blue)
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
                                           Text(selectedVehicle == nil ? Constants.DefaultValues.selectVehicle : selectedVehicle?.vehicleBrand ?? "").foregroundColor(colorScheme == .dark ? .white : .black).padding(.leading, 12)
                                           Spacer()
                                           Image(systemName: Constants.Icons.rightChevron).foregroundColor(.gray)
                                       }
                                   }
                                   .frame(height: 50)
                            }.padding(.horizontal)
                            Rectangle().frame(height: 2).foregroundColor(.gray.opacity(0.2)).padding(.horizontal)
                
                                // MARK: - Amount
                                    HStack {
                                        Image(systemName: Constants.Icons.rupeeSign).foregroundColor(.blue).padding(.leading).bold()
                                        TextField(Constants.Placeholders.enterAmount, text: $vm.amount).frame(height: 50).padding(.horizontal).keyboardType(.numberPad).focused($isFocused)
                                    }
                        }
                        
                    }
                 
                    
                    
                    // MARK: - Search
                    Button {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = Constants.Date.timeFormat
                        vm.time = dateFormatter.string(from: currentDate)
//                        isPublishView ? vm.apiCall(for: .fetchPolylineAndDistanceOfRide ) : nil
                            vm.date = Helper().dateToString(selectedDate: newSelectedDate ?? Date())
//                            vm.time = Helper().dateToString(selectedDate: newTime ?? Date())
                        if vm.originData != nil && vm.destinationData != nil {
                            isPublishView ?  vm.apiCall(for: .fetchPolylineAndDistanceOfRide) : vm.apiCall(for: .searchRide)
                            // To show searched Ride
                            isPublishView ? showMap.toggle() :  showCarPoolView.toggle()
                        } else {
                            showAlert.toggle()
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text(isPublishView ? Constants.DefaultValues.publish : Constants.Labels.search).bold()
                            Spacer()
                        }.frame(height: 50)
                            .background {
                                Color.blue
                            }.foregroundColor(.white)
                    }
                    .alert(isPresented: $vm.alertSuccess) {
                        Alert(title: Text(Constants.Alert.success), message: Text(Constants.Alert.ridePublishSuccess), dismissButton: .default(Text(Constants.Buttons.ok), action: {
                            
                        }))}
                    .alert(isPresented: $vm.alertFailure) {
                        Alert(title: Text(Constants.Alert.error), message: Text(Constants.Alert.failToPublishRide), dismissButton: .default(Text(Constants.Buttons.ok), action: {
                          
                        }))
                      
                    }
                   .navigationDestination(isPresented: $showCarPoolView, destination: {
                        CarPoolView().transition(.opacity)
                    })
                    .navigationDestination(isPresented: $showMap) {
                     ShowPolylineView()
                 }
                }.onTapGesture {
                    self.isFocused = false
                    self.showAlert = false
            }.cornerRadius(20)
        }   .background {
            Color.gray.opacity(0.1).cornerRadius(20)
        }.onAppear {
            vehicleVm.apiCall(method: .getVehicle)
        }.padding()
        
    }
    
    
    func timeFormat(currentDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.Date.timeFormat
       return dateFormatter.string(from: currentDate)

    }
   
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(isPublishView: .constant(true), isComingFromPublishedView: .constant(false), showAlert: .constant(false))
            .environmentObject(RegisterVehicleViewModel()).environmentObject(MapAndRidesViewModel()).environmentObject(BaseApiManager())
    }
}
