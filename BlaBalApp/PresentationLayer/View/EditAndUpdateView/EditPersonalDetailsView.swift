//
//  EditPersonalDetailsViw.swift
//  BlaBalApp
//
//  Created by ChicMic on 23/05/23.
//

import SwiftUI

struct EditPersonalDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: LoginSignUpViewModel
    @State var openCalendar: Bool = false
    @State var selectedDate : Date?
    var body: some View {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(spacing: 40) {
                        CustomTextfield(label: Constants.Labels.fname, placeholder: Constants.Placeholders.fname, value: $vm.fname)
                        CustomTextfield(label: Constants.Labels.lname, placeholder: Constants.Placeholders.lname, value: $vm.lname)
                        
                        VStack {
                            HStack {
                                Text(Constants.Labels.titles)
                                Spacer()
                            }.padding(.bottom, 5)
                            
                            HStack {
                                ForEach(Title.allCases, id: \.self) { title in
                                          HStack {
                                              Image(systemName: vm.selectedTitle == title.rawValue ? Constants.Icons.squarecheckmark : Constants.Icons.square).foregroundColor(.blue)
                                                  .onTapGesture {
                                                      vm.selectedTitle = title.rawValue
                                                  }
                                              Text(title.rawValue)
                                            
                                          }.font(.system(size: 20))
                                    Spacer()
                                          .foregroundColor(.primary)
                                      }
                            }
                        }
                        
                        VStack {
                            HStack {
                                Text(Constants.Labels.bday)
                                Spacer()
                            }.padding(.bottom, 5)
            
                                HStack(spacing: 20) {
                                    Image(systemName: Constants.Icons.calander).font(.title2).padding(.leading).foregroundColor(.blue)
                                   
                                    DatePickerTextField(placeholder: "", date: $selectedDate, pickerType: .date, isDOB: true)
                                    
//                                    HStack {
//                                        Text(Helper().dateToString(selectedDate: selectedDate)).foregroundColor(.black)
//                                        DatePicker("", selection: $selectedDate, in: minDate...maxDate, displayedComponents: .date)
//                                    }
                                   
                                    Spacer()
                                }.padding(.trailing, 10).frame(height: 50).background(.gray.opacity(0.2))
                                    .cornerRadius(24)
                            
                        }
                        

                        
                        CustomTextfield(label: Constants.Labels.bio, placeholder: Constants.Placeholders.bio, value: $vm.bio)
                        
                        CustomTextfield(label: Constants.Labels.travelPreference, placeholder: Constants.Placeholders.travelPreference, value: $vm.travelPreference)
                        
                        CustomTextfield(label: Constants.Labels.address, placeholder: Constants.Placeholders.post, value: $vm.postalAddress)
                        
                        Button {
                            vm.bday = Helper().dateToString(selectedDate: selectedDate ?? Calendar.current.date(from: DateComponents(year: 2009, month: 12, day: 31))!)
                            print(vm.bday)
//                                    vm.signUp()
                            vm.apiCall(forMethod: .signUp)
                            vm.isLoading = true
                        } label: {
                            Buttons(image: "", text: Constants.Buttons.save, color: Constants.Colors.bluecolor)
                        }
                      
                        .alert( isPresented: $vm.successUpdate) {
                            Alert(title: Text(Constants.Alert.success), message: Text(Constants.Alert.updateUserSucess), dismissButton: .default(Text(Constants.Buttons.ok), action: {
                                dismiss()
                            }))
                            
                            
                        }
                    // MARK: - Alert user updated successfully
                    }.padding()
                }.overlay {
                    if vm.isLoading {
                        ProgressView().progressViewStyle(.circular)
                    }
                }.alert(isPresented: $vm.updateAlertProblem){
                    Alert(title: Text(Constants.Alert.error),
                          message: Text(ErrorAlert.profileUpdate.rawValue),
                          dismissButton: .cancel(Text(Constants.Buttons.ok)))

            }
                
              
                
                Spacer()
            }.navigationTitle(Constants.Header.details)
            .onTapGesture {
                hideKeyboard()
            }
            .onDisappear {
                vm.isUpdating = false
            }
            .onAppear {
                vm.isUpdating = true
                   if let data = vm.recievedData?.status.data {
                       vm.fname = data.firstName
                       vm.lname = data.lastName
                       vm.bday = data.dob
                       selectedDate = Helper().stringTodate(date: data.dob)
                       print(Helper().stringTodate(date: data.dob))
                       print(selectedDate, data.dob)
                       vm.phoneNumber = data.phoneNumber ?? ""
                       vm.postalAddress = data.postalAddress ?? ""
                       vm.travelPreference = data.travelPreferences ?? ""
                       vm.bio = data.bio ?? ""
                       vm.selectedTitle = data.title
//                       selectedDate = Helper().stringTodate(date: )
                   }
      
               
               
            }
        
    }
}

struct EditPersonalDetailsViw_Previews: PreviewProvider {
    static var previews: some View {
        EditPersonalDetailsView().environmentObject(LoginSignUpViewModel())
    }
}
