//
//  EditPersonalDetailsViw.swift
//  BlaBalApp
//
//  Created by ChicMic on 23/05/23.
//

import SwiftUI

struct EditPersonalDetailsView: View {
    @Environment(\.dismiss) var dismiss
//    @EnvironmentObject var vm: LoginSignUpViewModel
    @ObservedObject var vm: LoginSignUpViewModel
    @State var openCalendar: Bool = false
    let minDate = Calendar.current.date(from: DateComponents(year: 1940, month: 1, day: 1))!
    let maxDate = Calendar.current.date(from: DateComponents(year: 2015, month: 12, day: 31))!
    var body: some View {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(spacing: 40) {
//                        CustomTextfield(label: Constants.Labels.email, placeholder: Constants.Placeholders.emailplc, value: $vm.email)
                        CustomTextfield(label: Constants.Labels.fname, placeholder: Constants.Placeholders.fname, value: $vm.fname)
                        CustomTextfield(label: Constants.Labels.lname, placeholder: Constants.Placeholders.lname, value: $vm.lname)
                        
                        VStack {
                            HStack {
                                Text(Constants.Labels.titles)
                                Spacer()
                            }.padding(.bottom, 5)
                            
                            HStack {
                                ForEach(LoginSignUpViewModel.Title.allCases, id: \.self) { title in
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
                            Button {
                                openCalendar = true
                            } label: {
                                HStack(spacing: 20) {
                                    Image(systemName: Constants.Icons.calander).font(.title2).padding(.leading)
                                    Text(vm.bday).foregroundColor(.black)
                                    Spacer()
                                }.padding(.trailing, 10).frame(height: 50).background(.gray.opacity(0.2))
                                    .cornerRadius(24)
                            }.sheet(isPresented: $openCalendar) {
                                CalendarView(selectedDate: .constant(Date()), isDob: .constant(true))
                            }
                        }
                        
                        CustomTextfield(label: Constants.Labels.phone, placeholder: Constants.Placeholders.phonenumber, value: $vm.phoneNumber).keyboardType(.phonePad)
                        
                        CustomTextfield(label: Constants.Labels.bio, placeholder: Constants.Placeholders.bio, value: $vm.bio)
                        
                        CustomTextfield(label: Constants.Labels.travelPreference, placeholder: Constants.Placeholders.travelPreference, value: $vm.travelPreference)
                        
                        CustomTextfield(label: Constants.Labels.address, placeholder: Constants.Placeholders.post, value: $vm.postalAddress)
                        
//                        UserDefaults.standard.set(vm.recievedData, forKey: "UserData")
                        
                        Button {
                            vm.isUpdating.toggle()
                            vm.signUp()
                        } label: {
                            Buttons(image: "", text: Constants.Buttons.save, color: Constants.Colors.bluecolor)
                        }.alert( isPresented: $vm.alert) {
                            Alert(title: Text("Success"), message: Text("User Updated Successfully"), dismissButton: .cancel() )
                        }
                    // MARK: - Alert user updated successfully
                    }.padding()
                }
                
              
                
                Spacer()
            }.navigationTitle(Constants.Header.details).onAppear {
//                vm.getUser()
                if let data = vm.recievedData?.status.data {
                    vm.fname = data.firstName
                    vm.lname = data.lastName
                    vm.bday = data.dob
                    vm.phoneNumber = data.phoneNumber
                    vm.postalAddress = data.postalAddress
                    vm.travelPreference = data.travelPreferences
                    vm.selectedTitle = data.title
                    vm.email = data.email
                    vm.bio = data.bio
                }
            }.overlay {
                
            }
        
    }
}

struct EditPersonalDetailsViw_Previews: PreviewProvider {
    static var previews: some View {
        EditPersonalDetailsView(vm: LoginSignUpViewModel())
    }
}
