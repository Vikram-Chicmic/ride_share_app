//
//  ProfileView.swift
//  BlaBalApp
//
//  Created by ChicMic on 11/05/23.
//

import SwiftUI

struct ProfileView: View {
    @State var navigate: Bool = false
    @State var navigateToRegisterVehicle = false
    @State var detail: Welcome?
    @ObservedObject var vm: LoginSignUpViewModel
    @State var navigateToAllVehiclePage = false
    @State var navigateToChangePassword = false
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
              
                        
                // MARK: - edit personal detail
                        Button {
                            navigate.toggle()
                        }label: {
                            Text(Constants.Buttons.editprofile).font(.system(size: 20))
                        }.padding(.vertical)
                            .navigationDestination(isPresented: $navigate) {
                                EditPersonalDetailsView( vm: vm)
                            }
                        
                    }
                    
                    Spacer()
                   
                }
                
                Button {
                    navigateToChangePassword.toggle()
                } label: {
                    HStack {
                        Text("Change password")
                        Spacer()
                    }
                }.fullScreenCover(isPresented: $navigateToChangePassword) {
                    ChangePasswordView()
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    Section {
                        Divider()
                        
                        Text(Constants.Header.varifyProfile).font(.title2).fontWeight(.semibold)
                        Button {
                            
                        } label: {
                            ProfileButtons(text: Constants.Buttons.verifyId)
                        }

                        Button {
                            
                        } label: {
                            ProfileButtons(text: Constants.Buttons.verifyEmail)
                        }
                    }
                    
                    Section(header: Spacer()) {
         
                        
                        Divider()
                        
                        Text(Constants.Header.vehicle).font(.title2).fontWeight(.semibold)
                        Button {
                            navigateToRegisterVehicle.toggle()
                        } label: {
                            ProfileButtons(text: Constants.Buttons.addVehicle)

                        }.navigationDestination(isPresented: $navigateToRegisterVehicle) {
                            RegisterVehicleView()
                        }
                        
                    }
                    
                 Spacer()
                    
                    Button {
                        navigateToAllVehiclePage.toggle()
                    } label: {
                        Text(Constants.Buttons.getVehicleInfo)
                    }.navigationDestination(isPresented: $navigateToAllVehiclePage) {
                        AllVehicleView()
                    }
                    
                    
                    // MARK: - Logout Button
                    Button {
                        vm.logoutUser()
                        presentationMode.wrappedValue.dismiss()
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
        
        NavigationStack {
            ProfileView(vm: LoginSignUpViewModel())
        }
    }
}
