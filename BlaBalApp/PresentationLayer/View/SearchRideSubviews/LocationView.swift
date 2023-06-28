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
    @EnvironmentObject var vm: MapAndSearchRideViewModel
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
                            MapView( isOrigin: $isOrigin)
                        })
                        .padding(.top, 4)
                        .frame(height: 45)
                        Divider().frame(height: 1).padding(.horizontal)


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
                        Divider().frame(height: 1).padding(.horizontal)
                       
                        
                        // MARK: - Calendar
                        HStack {
                            HStack(spacing: 20) {
                                Image(systemName: Constants.Icons.calander).font(.title3).padding(.leading)
                                DatePickerTextField(placeholder: "", date: $newSelectedDate, pickerType: PickerType.date).padding(.leading, 8)
                                Spacer()
                                }
                                .padding(.trailing, 10)
                                .frame(height: 40)
                       
                            
                            
                            // MARK: - Seats
                                Button {
                                    addSeatNavigate.toggle()
                                } label: {
                                    HStack {
                                        Image(systemName: Constants.Icons.person).font(.title2)
                                        Text("\(vm.passengers)").font(.title2).foregroundColor(colorScheme == .dark ? .white : .black)
                                    }
                                }.padding(.trailing, 40)
                            .sheet(isPresented: $addSeatNavigate) {
                                AddSeatView(seat: $vm.passengers, temp: seats, isPublishView: $isPublishView)
                            }
                        }.frame(height: 40)
                     
                        
                        
                        if isPublishView {
                            // MARK: - Time
                            HStack {
                                Image(systemName: Constants.Icons.clock).font(.title2).foregroundColor(.blue).padding(.leading).bold()
                                DatePickerTextField(placeholder: "", date: $newSelectedDate, pickerType: PickerType.time).padding(.leading)
                                Spacer()
                            }.frame(height: 50)
                            
                            Divider().frame(height: 1).padding(.horizontal)
                            
                            
                            
                            // MARK: - Discription
                            HStack {
                                Image(systemName: Constants.Icons.pencil).font(.title2).foregroundColor(.blue).padding(.leading).bold()
                                TextField(Constants.Placeholders.description, text: $vm.aboutRide).frame(height: 60).padding(.horizontal).focused($isFocused)
                                Divider().frame(height: 20)
                            }
                            Divider().frame(height: 1).padding(.horizontal)
                            
                        
                            //MARK: - Vehicle Selection
                            HStack {
                                Image(systemName: Constants.Icons.carfill)
                                    .font(.title3)
                                    .foregroundColor(.blue)
                                    .bold()
                                
                              
                                
//                                if let data = vehicleVm.decodedVehicleData?.data {
//                                    TextFieldWithPickerAsInputView(data: data, placeholder: "", selectionIndex: $vehicleIndex, text: $vehicleName)
//                                }
                                
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
                                   .frame(height: 60)
                            }.padding(.horizontal)
                            Divider().frame(height: 1).padding(.horizontal)
//
//                                //MARK: - Map
//                                    Button {
//                                        vm.apiCall(for: .fetchPolylineAndDistanceOfRide)
//                                        self.showMap.toggle()
//                                    } label: {
//                                        HStack{
//                                            Text("Open map").padding()
//                                            Image(systemName: Constants.Icons.rightChevron)
//                                        }.padding(.horizontal).disabled(vm.destinationData?.name == "" || vm.originData?.name == "")
//                                    }
//                                   .navigationDestination(isPresented: $showMap) {
//                                    ShowPolylineView()
//                                }
                                
//                               Divider().frame(height: 1).background(Color.blue).padding(.horizontal)
                
                                //MARK: - Amount
                                    HStack {
                                        Image(systemName: Constants.Icons.rupeeSign).font(.title2).foregroundColor(.blue).padding(.leading).bold()
                                        TextField(Constants.Placeholders.enterAmount, text: $vm.amount).frame(height: 60).padding(.horizontal).keyboardType(.numberPad).focused($isFocused)
                                    }
                                
                            
                          
                           
                        }
                        
                    }.background {
                        Image("Bank")
                            
                                   .mask(BottomCornerRadiusShape(cornerRadius: 10)).overlay {
                            TransparentBlurView(removeAllFilters: false).mask(BottomCornerRadiusShape(cornerRadius: 10))
                        }
                    }
                    
                    
                    // MARK: - Search
                    Button {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = Constants.Date.timeFormat
                        vm.time = dateFormatter.string(from: currentDate)
                        vm.apiCall(for: .fetchPolylineAndDistanceOfRide )
                        if isComingFromPublishedView {
                            vm.apiCall(for: .updateRide)
                        } else {
                            vm.date = Helper().dateToString(selectedDate: newSelectedDate ?? Date())
                            isPublishView ?  vm.apiCall(for: .fetchPolylineAndDistanceOfRide) : vm.apiCall(for: .searchRide)
                            isPublishView ? showCarPoolView = false :  showCarPoolView.toggle()
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text(isPublishView ? Constants.DefaultValues.publish : Constants.Labels.search).bold()
                            Spacer()
                        }.frame(height: 50)
                            .background {
                                Color.blue
                            }.opacity(isDisable ? 0.5 : 1.0).foregroundColor(.white)
                    }
                    .alert(isPresented: $baseApi.alert) {
                        baseApi.successAlert ?
                        Alert(title: Text(Constants.Alert.success), message: Text(Constants.Alert.ridePublishSuccess), dismissButton: .default(Text(Constants.Buttons.ok), action: {
                           
                        }))
                        :
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
            }.cornerRadius(20)
        }
        
    }
    
    
    func timeFormat(currentDate: Date)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.Date.timeFormat
       return dateFormatter.string(from: currentDate)

    }
   
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(isPublishView: .constant(true), isComingFromPublishedView: .constant(false))
            .environmentObject(RegisterVehicleViewModel()).environmentObject(MapAndSearchRideViewModel()).environmentObject(BaseApiManager())
    }
}
