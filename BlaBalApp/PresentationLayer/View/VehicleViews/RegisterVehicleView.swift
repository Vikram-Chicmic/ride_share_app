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
    @State var selectedYear: String? = "1981"
    @EnvironmentObject var networkStatusManager: NetworkStatusManager
    @State var showCustomAlert = false
    @Binding var hasUpdated: Bool
    @State var alertNow = false
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                   
                            Text(Constants.Labels.selectCountry)
                                HStack {
                                    TextFieldWithPickerAsInputView(data: Constants.Arrays.country, placeholder: "Select Country", selectionIndex: $index, text: $vm.selectedCountry)
                                    Spacer()
                                    Image(systemName: "chevron.down").foregroundColor(.gray).opacity(0.3)
                                }
                                    .padding()
                                    .background(.gray.opacity(0.2))
                                    .cornerRadius(10)
                                    
                            
                        CustomTextfield(label: Constants.Labels.vehicleBrand, placeholder: Constants.Placeholders.brand, value: $vm.vehicleBrand)
                        CustomTextfield(label: Constants.Labels.vehicleModel, placeholder: Constants.Placeholders.model, value: $vm.vehicleModel)
                        CustomTextfield(label: Constants.Labels.plateNumber, placeholder: Constants.Placeholders.plateNumber, value: $vm.plateNumber)
                        VStack(alignment: .leading) {
                            Text(Constants.Labels.vehicleType)
                            HStack {
                                TextFieldWithPickerAsInputView(data: Constants.Arrays.vehicleType, placeholder: "Select vehicle", selectionIndex: $index, text: $vm.selectedVehicleType)
                                Spacer()
                                Image(systemName: "chevron.down").foregroundColor(.gray).opacity(0.3)
                            }
                                .padding()
                                .background(.gray.opacity(0.2))
                                .cornerRadius(10)
                         
                            Text(Constants.Labels.vehicleColor).padding(.top)
                            HStack {
                                TextFieldWithPickerAsInputView(data: Constants.Arrays.vehicleColors, placeholder: "Select color", selectionIndex: $index, text: $vm.selectedVehicleColor)
                                Spacer()
                                Image(systemName: "chevron.down").foregroundColor(.gray).opacity(0.3)
                            }
                                .padding()
                                .background(.gray.opacity(0.2))
                                .cornerRadius(10)
                            
                            Text(Constants.Labels.year).padding(.top)
                            HStack {
                                TextFieldWithPickerAsInputView(data: years, placeholder: "Select year", selectionIndex: $index, text: $selectedYear)
                                Spacer()
                                Image(systemName: "chevron.down").foregroundColor(.gray).opacity(0.3)
                            }
                                .padding()
                                .background(.gray.opacity(0.2))
                                .cornerRadius(10)
                            
                        }
   
                        Button {
                            if let selectedYear = selectedYear {
                                vm.madeYear = Int(selectedYear)
                                
                                if vm.vehicleModel.isEmpty || vm.vehicleBrand.isEmpty || vm.plateNumber.isEmpty {
                                    showCustomAlert.toggle()
                                } else {
                                    if isUpdateVehicle {
                                        vm.isUpdatingVehicle = true
                                        vm.apiCall(method: .vehicleUpdate)
                                        alertNow.toggle()
                                    } else {
                                        vm.apiCall(method: .vehicleRegister)
                                        alertNow.toggle()
                                    }
                                }
                                  
                                
                            } else {
                                showCustomAlert.toggle()
                            }
                        } label: {
                            Buttons(image: "", text: Constants.Buttons.save, color: Constants.Colors.bluecolor).padding(.vertical)
                        }
                     
                    }.padding()
                }.padding(.bottom).scrollIndicators(.hidden)
            }.onTapGesture {
                hideKeyboard()
            }.opacity(showCustomAlert ? 0.5 : 1.0)
            if showCustomAlert {
                CustomAlert(text: "Fields are empty", dismiss: $showCustomAlert)
            }
        } .alert(isPresented: $alertNow) {
            
            Alert(title: vm.successAlert ? Text(Constants.Alert.success) : Text(Constants.Alert.error),
                  message: vm.successAlert ?
                                    isUpdateVehicle ?
                                        Text(SuccessAlerts.updateVehicle.rawValue)
                                    : Text(SuccessAlerts.addVehicle.rawValue)
                                :
                                        isUpdateVehicle ?
                                            Text(ErrorAlert.updateVehicle.rawValue)
                                            :
                                        Text(ErrorAlert.addVehicle.rawValue),
                  
                      dismissButton: .cancel(Text(Constants.Buttons.ok), action: {
                vm.successAlert ?
                    isUpdateVehicle ?
                        lastTAsk()
                        
                :  dismiss()
                : dismiss()
                }))
        
//            return Alert(title: Text("Unknown error"))
        }
        .onAppear {
            if isUpdateVehicle {
                vm.isRegistering = false
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
    func lastTAsk(){
        hasUpdated.toggle()
        vm.isUpdatingVehicle = false
        dismiss()
    }
}

struct RegisterVehicleView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterVehicleView(isUpdateVehicle: .constant(true), index: 0, hasUpdated: .constant(false)).environmentObject(RegisterVehicleViewModel())
    }
}
