//
//  EditRide.swift
//  BlaBalApp
//
//  Created by ChicMic on 29/06/23.
//

import SwiftUI

struct EditRide: View {
    @State var showMapView = false
    @State var addSeatNavigate = false
    @State var isOrigin = true
    @State var newSelectedDate : Date? = Date()
    @EnvironmentObject var vehicleVm: RegisterVehicleViewModel
    @State var seats: Int = 1
    @State var price: String = "0"
    @State var aboutRide: String = ""
    @FocusState var isFocused: Bool
    @State var vehicles: [String] = []
    @State var selectedVehicle: String?
    @State var vehicleId: Int?
    var body: some View {
        VStack(spacing: 10) {
            
            Button {
                showMapView.toggle()
            }label: {
                HStack {
                    Image(systemName: Constants.Icons.circle)
                    Text("Enter your start location")
                    Spacer()
                }.padding().background(Color.gray.opacity(0.2)).cornerRadius(25)
            }.sheet(isPresented: $showMapView, content: {
                MapView( isOrigin: $isOrigin)
            })
            
            
            Button {
                isOrigin = false
                showMapView.toggle()
                } label: {
                    HStack {
                        Image(systemName: Constants.Icons.circle)
                        Text("Enter your start location")
                        Spacer()
                    }.padding().background(Color.gray.opacity(0.2)).cornerRadius(25)
            }
            .sheet(isPresented: $showMapView, content: {
                MapView( isOrigin: $isOrigin)
            })
            
            
          
            HStack {
                HStack {
                    Image(systemName: Constants.Icons.calander).font(.title3).padding(.leading).foregroundColor(.blue)
                    DatePickerTextField(placeholder: "", date: $newSelectedDate, pickerType: PickerType.date).padding(.leading, 8)
                    Spacer()
                    }
                Spacer()
                   
            }.frame(height: 50).background(Color.gray.opacity(0.2)).cornerRadius(25)
            
            HStack {
               
                HStack {
                    Image(systemName: Constants.Icons.person).foregroundColor(.blue).padding(.trailing).font(.title2).bold()
                    Image(systemName: Constants.Icons.minuscircle).onTapGesture {
                        if seats > 1 {
                            seats -= 1
                        }
                    }
                    Text("\(seats)").padding(.horizontal)
                    Image(systemName: Constants.Icons.pluscircle).onTapGesture {
                        if seats < 8 {
                            seats += 1
                        }
                    }
                }.padding().background(Color.gray.opacity(0.2)).cornerRadius(25)
                
                
                HStack {
                    Image(systemName: Constants.Icons.rupeeSign).font(.title2).foregroundColor(.blue).padding(.leading).bold()
                    TextField("", text: Binding(
                        get: { price },
                        set: { newValue in
                            let truncatedValue = String(newValue.prefix(5))
                            price = truncatedValue
                        }
                    )).padding().keyboardType(.numberPad).focused($isFocused)
                }.background(Color.gray.opacity(0.2)).cornerRadius(25)
            }
            
            HStack {
                Image(systemName: Constants.Icons.carfill)
                    .font(.title3)
                    .foregroundColor(.blue)
                    .bold()
                Menu {
                       if let data = vehicleVm.decodedVehicleData?.data {
                           ForEach(data.indices, id: \.self) { index in
                               Button {
                                   selectedVehicle = "\(data[index])"
                                   vehicleId = data[index].id
                               } label: {
                                   Text("\(data[index].vehicleBrand)")
                               }
                           }
                       }
                   } label: {
                       HStack {
                           Text(selectedVehicle == nil ? Constants.DefaultValues.selectVehicle : selectedVehicle ?? "").padding(.leading, 12)
                           Spacer()
                           Image(systemName: Constants.Icons.rightChevron).foregroundColor(.gray)
                       }
                   }
                   .frame(height: 60)
            }.padding(.horizontal).background(Color.gray.opacity(0.2)).cornerRadius(25)
            
            
            
          

            HStack {
                Image(systemName: Constants.Icons.pencil).font(.title2).foregroundColor(.blue).padding(.leading).bold()
                TextField(Constants.Placeholders.description, text: $aboutRide).frame(height: 60).padding(.horizontal).focused($isFocused)
                Divider().frame(height: 20)
            }.background(Color.gray.opacity(0.2)).cornerRadius(25)
            
            HStack {
                Image(systemName: Constants.Icons.clock).font(.title2).foregroundColor(.blue).padding(.leading).bold()
                DatePickerTextField(placeholder: "", date: $newSelectedDate, pickerType: PickerType.time).padding(.leading)
                Spacer()
            }.frame(height: 30).padding(.vertical).background(Color.gray.opacity(0.2)).cornerRadius(25)
            
            
            
            Button {
                //
            } label: {
                Buttons(image: "", text: "Update", color: Constants.Colors.bluecolor)
            }

            
        }.onAppear {
            if let data = vehicleVm.decodedVehicleData?.data {
                for index in data.indices {
                  vehicles.append(data[index].vehicleName)
                }
            }
        }
        .navigationTitle("Updatee Ride").padding()
    }
}

struct EditRide_Previews: PreviewProvider {
    static var previews: some View {
        EditRide().environmentObject(RegisterVehicleViewModel())
    }
}
