//
//  RegisterVehicleView.swift
//  BlaBalApp
//
//  Created by ChicMic on 24/05/23.
//

import SwiftUI

struct RegisterVehicleView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = RegisterVehicleViewModel()

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text(Constants.Labels.selectCountry)
                        Spacer()
                        Picker("", selection: $vm.selectedCountry) {
                            ForEach(Constants.Arrays.country, id: \.self) { country in
                                Text(country)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                    }
                    
                    CustomTextfield(label: Constants.Labels.plateNumber, placeholder: Constants.Placeholders.plateNumber, value: $vm.plateNumber)
                    
                    CustomTextfield(label: Constants.Labels.vehicleBrand, placeholder: Constants.Placeholders.brand, value: $vm.vehicleBrand)
                    
                    CustomTextfield(label: Constants.Labels.vehicleModel, placeholder: Constants.Placeholders.model, value: $vm.vehicleModel)
                    
                    HStack {
                        Text(Constants.Labels.vehicleType)
                        Spacer()
                        Picker("", selection: $vm.selectedVehicleType) {
                            ForEach(Constants.Arrays.vehicleType, id: \.self) { country in
                                Text(country)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                    }
                    
                    HStack {
                        Text(Constants.Labels.vehicleColor)
                        Spacer()
                        Picker("", selection: $vm.selectedVehicleColor) {
                            ForEach(Constants.Arrays.vehicleColors, id: \.self) { country in
                                Text(country)
                            }
                        }                .pickerStyle(MenuPickerStyle())
                        .padding()
                    }
                    
                    CustomTextfield(label: Constants.Labels.year, placeholder: Constants.Placeholders.year, value: $vm.madeYear)
                    
                    
                    Button {
                        vm.registerVehicle()
                    } label: {
                        Buttons(image: "", text: Constants.Buttons.save, color: Constants.Colors.bluecolor).padding(.vertical)
                    }.alert(isPresented: $vm.alertResponse) {
                        Alert(title: Text(Constants.Alert.success),
                              message: Text(Constants.Alert.vehicleAddSuccess),
                              dismissButton: .cancel(Text(Constants.Labels.ok)) {
                            dismiss()
                        }
                        )
                    }
                  
             
                    
                    Spacer()
                    
                    
                   
                          
                }.padding()
            }
        }.navigationTitle(Constants.Header.registerVehicle).onAppear {
            vm.isRegistering = true
        }
    }
    
 
    
}

struct RegisterVehicleView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterVehicleView()
    }
}
