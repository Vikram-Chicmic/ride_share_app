//
//  RegisterVehicleView.swift
//  BlaBalApp
//
//  Created by ChicMic on 24/05/23.
//

import SwiftUI

struct RegisterVehicleView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: RegisterVehicleViewModel
    @Binding var isUpdateVehicle: Bool
    let years = (1980...2023).map { String($0) }
    @State var index: Int = 0
    @State var selectedYear: String?
    @State var showCustomAlert = false
    @Binding var hasUpdated: Bool
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                   
                            Text(Constants.Labels.selectCountry)
                            HStack{
                                
                                TextFieldWithPickerAsInputView(data: Constants.Arrays.country, placeholder: "Select Country", selectionIndex: $index, text: $vm.selectedCountry).padding()
                                    .background(.gray.opacity(0.2))
                                    .cornerRadius(24)
                            }
                        
                        
                        
                   
                        
                        CustomTextfield(label: Constants.Labels.vehicleBrand, placeholder: Constants.Placeholders.brand, value: $vm.vehicleBrand)
                        
                        CustomTextfield(label: Constants.Labels.vehicleModel, placeholder: Constants.Placeholders.model, value: $vm.vehicleModel)
                        CustomTextfield(label: Constants.Labels.plateNumber, placeholder: Constants.Placeholders.plateNumber, value: $vm.plateNumber)
                        
                        VStack(alignment: .leading) {
                            Text(Constants.Labels.vehicleType)
                            TextFieldWithPickerAsInputView(data: Constants.Arrays.vehicleType, placeholder: "Select vehicle", selectionIndex: $index, text: $vm.selectedVehicleType).padding()
                                .background(.gray.opacity(0.2))
                                .cornerRadius(24)
                            Text(Constants.Labels.vehicleColor).padding(.top)
                            TextFieldWithPickerAsInputView(data: Constants.Arrays.vehicleColors, placeholder: "Select color", selectionIndex: $index, text: $vm.selectedVehicleColor).padding()
                                .background(.gray.opacity(0.2))
                                .cornerRadius(24)
                            Text(Constants.Labels.year).padding(.top)
                            TextFieldWithPickerAsInputView(data: years, placeholder: "Select year", selectionIndex: $index, text: $selectedYear).padding()
                                .background(.gray.opacity(0.2))
                                .cornerRadius(24)
                            
                        }
                           
                        
    //                    CustomTextfield(label: Constants.Labels.year, placeholder: Constants.Placeholders.year, value: $vm.madeYear).keyboardType(.numberPad)
                     
                        Button {
                            if let selectedYear = selectedYear {
                                vm.madeYear = Int(selectedYear)
                                
                                if vm.vehicleModel.isEmpty || vm.vehicleBrand.isEmpty || vm.plateNumber.isEmpty {
                                    showCustomAlert.toggle()
                                } else {
                                    if isUpdateVehicle {
                                        vm.isUpdatingVehicle.toggle()
                                        vm.apiCall(method: .vehicleUpdate)
                                    } else {
                                        vm.apiCall(method: .vehicleRegister)
                                    }
                                }
                                
                            } else {
                                showCustomAlert.toggle()
                            }
                        } label: {
                            Buttons(image: "", text: Constants.Buttons.save, color: Constants.Colors.bluecolor).padding(.vertical)
                        }.alert(isPresented: $vm.successAlert) {
                            Alert(title: Text(Constants.Alert.success),
                                  message: Text(Constants.Alert.vehicleAddSuccess),
                                  dismissButton: .cancel(Text(Constants.Labels.ok)) {
                                if isUpdateVehicle {
                                    hasUpdated.toggle()
                                }
                                dismiss()
                            }
                            )
                        }
                      
                 
                        
                
                        
                        
                       
                              
                    }.padding()
                }.scrollIndicators(.hidden)
            }.opacity(showCustomAlert ? 0.5 : 1.0)
            if showCustomAlert {
                CustomAlert(text: "Fields are empty", dismiss: $showCustomAlert)
            }
        }
        .onAppear {
            if isUpdateVehicle {
                vm.isRegistering = false
                vm.isUpdatingVehicle = true
                selectedYear = "\(vm.madeYear!)"
            } else {
                vm.isRegistering = true
                vm.isUpdatingVehicle = false
                vm.vehicleBrand = ""
                vm.vehicleModel = ""
                vm.plateNumber =  ""
                vm.madeYear =  1981
                
                vm.selectedVehicleType =  Constants.DefaultValues.vehicleType
                vm.selectedVehicleColor = Constants.DefaultValues.vehicleColor
                vm.selectedCountry = Constants.DefaultValues.country
            }
        }.navigationTitle(isUpdateVehicle ? "Update Vehicle" : Constants.Header.registerVehicle)
    }
    
 
    
}

struct RegisterVehicleView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterVehicleView(isUpdateVehicle: .constant(true), index: 0, hasUpdated: .constant(false)).environmentObject(RegisterVehicleViewModel())
    }
}
