//
//  ProfileView.swift
//  BlaBalApp
//
//  Created by ChicMic on 11/05/23.
//

import SwiftUI

struct ProfileView: View {
    @State var navigate: Bool = false
    @State var navigateToPhoneVerification: Bool = false
    @State var navigateToRegisterVehicle = false
    @State var detail: Welcome?
    @ObservedObject var vm: LoginSignUpViewModel
    @State var navigateToAllVehiclePage = false
    @State var navigateToChangePassword = false
    @EnvironmentObject var sessionManager: SessionManager
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(alignment: .leading) {
            Text(Constants.Labels.person).font(.largeTitle).fontWeight(.semibold)
            Divider()
            ScrollView {
                VStack {
                    ImageView()
                    
                    VStack(spacing: 5) {
                        if let data = vm.recievedData?.status.data {
                            Text(data.firstName + " " + data.lastName).font(.title).fontWeight(.semibold)
                        }
                    }
                    
                    Spacer()
                   
                }
                
                
      
                VStack(alignment: .leading, spacing: 15) {
                    
                    Section {
                        Divider()
                        
                        Text(Constants.Header.yourProfile).font(.title2).fontWeight(.semibold)
                        VStack(alignment: .leading, spacing: 10) {
                            ProfileDetailTileView(image: Constants.Icons.phone, value: vm.recievedData?.status.data?.phoneNumber ?? Constants.DefaultValues.noPhone)
                            ProfileDetailTileView(image: Constants.Icons.mail, value: vm.recievedData?.status.data?.email ?? "")
                            ProfileDetailTileView(image: Constants.Icons.calander, value: vm.recievedData?.status.data?.dob ?? Constants.DefaultValues.bday)
                            ProfileDetailTileView(image: Constants.Icons.personText, value: vm.recievedData?.status.data?.bio ?? Constants.DefaultValues.bio)
                        }.padding(.leading)
                    }
                    
                    VStack {
                        // MARK: - edit personal detail
                    Divider()
                        Button {
                            navigate.toggle()
                        }label: {
                            HStack{
                                Text(Constants.Buttons.editprofile)
                                Spacer()
                        Image(systemName: Constants.Icons.rightChevron)
                    }
                        }.frame(minHeight: 40)
                            .navigationDestination(isPresented: $navigate) {
                                EditPersonalDetailsView()
                            }
                            Divider()
                        
                        //MARK: - Change Password
                            Button {
                                navigateToChangePassword.toggle()
                            } label: {
                                HStack {
                                    Text(Constants.Buttons.changePassword)
                                    Spacer()
                                    Image(systemName: Constants.Icons.rightChevron)                    }
                            }.frame(minHeight: 40).fullScreenCover(isPresented: $navigateToChangePassword) {
                                ChangePasswordView()
                            }
                            Divider()
                            
                        //MARK: - Phone verification
                            Button {
                                navigateToPhoneVerification.toggle()
                            } label: {
                                HStack {
                                    Text(Constants.Buttons.verifyNumber)
                                    Spacer()
                                    Image(systemName: Constants.Icons.rightChevron)
                                }
                            }.frame(minHeight: 40).navigationDestination(isPresented: $navigateToPhoneVerification) {
                                PhoneView()
                            }
                            
                    }
                    
                    Divider()
                    
                    Section() {
                        Text(Constants.Header.vehicle).font(.title2).fontWeight(.semibold).padding(.top)
                        Button {
                            navigateToRegisterVehicle.toggle()
                        } label: {
                            HStack {
                                ProfileButtons(text: Constants.Buttons.addVehicle)
                                Spacer()
                                Image(systemName: Constants.Icons.rightChevron)
                            }


                        }.navigationDestination(isPresented: $navigateToRegisterVehicle) {
                            RegisterVehicleView(isUpdateVehicle: .constant(false))
                        }
                        
                    }
                    Divider()
                    Button {
                        navigateToAllVehiclePage.toggle()
                    } label: {
                        HStack {
                            Text(Constants.Buttons.getVehicleInfo)
                            Spacer()
                            Image(systemName: Constants.Icons.rightChevron)
                        }
                    }.frame(minHeight: 40).navigationDestination(isPresented: $navigateToAllVehiclePage) {
                        AllVehicleView()
                    }
                    
                    
                    // MARK: - Logout Button
                    Button {
//                        vm.logoutUser()
                        sessionManager.isLoggedIn.toggle()
                           
                    }label: {
                        HStack {
                            Spacer()
                            Text(Constants.Buttons.logout).font(.title2).frame(height: 45)
                            Spacer()
                        }.foregroundColor(.white).background(.red).cornerRadius(10).padding(.bottom)
                    }.padding(.top, 20)
                }
            }.scrollIndicators(.hidden)
         
            
            
            
            
            Spacer()
            
          
        }.onAppear {
            vm.getUser()
        }.padding(.horizontal)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(vm: LoginSignUpViewModel())
                .environmentObject(SessionManager()) // Inject the SessionManager environment object
        
    }
}
