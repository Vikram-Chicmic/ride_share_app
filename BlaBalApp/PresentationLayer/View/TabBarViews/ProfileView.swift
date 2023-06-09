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
    @State var showAlert: Bool = false
    @EnvironmentObject var vm: LoginSignUpViewModel
    @State var navigateToAllVehiclePage = false
    @State var navigateToChangePassword = false
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var baseApi: BaseApiManager
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
            VStack(alignment: .leading) {
                Text(Constants.Labels.person).font(.title).fontWeight(.semibold).padding(.top).padding(.leading)
                Rectangle().frame(height: 3).foregroundColor(.gray.opacity(0.2))
                ScrollView {
                    VStack {
                        ImageView()
                        VStack(spacing: 5) {
                            if let data = vm.recievedData?.status.data {
                                Text(data.firstName + " " + data.lastName).font(.title).fontWeight(.semibold)
                            }
                        }
                        Rectangle().frame(height: 20).foregroundColor(.gray.opacity(0.2))
                    }
                    VStack(alignment: .leading, spacing: 15) {
                        Section {
                            Text(Constants.Header.yourProfile).font(.title2).fontWeight(.semibold).padding(.leading)
                            VStack(alignment: .leading, spacing: 10) {
                                ProfileDetailTileView(image: Constants.Icons.phone, value: vm.recievedData?.status.data?.phoneNumber ?? Constants.DefaultValues.noPhone)
                                ProfileDetailTileView(image: Constants.Icons.mail, value: vm.recievedData?.status.data?.email ?? "")
                                ProfileDetailTileView(image: Constants.Icons.calander, value: vm.recievedData?.status.data?.dob ?? Constants.DefaultValues.bday)
                                ProfileDetailTileView(image: Constants.Icons.personText, value: vm.recievedData?.status.data?.bio ?? Constants.DefaultValues.bio)
                            }.padding(.leading)
                        }
                        
                        Rectangle().frame(height: 20).foregroundColor(.gray.opacity(0.2))
                        
                        VStack {
                            // MARK: - edit personal detail
                     
                            Button {
                                navigate.toggle()
                            }label: {
                                HStack {
                                    Text(Constants.Buttons.editprofile)
                                    Spacer()
                            Image(systemName: Constants.Icons.rightChevron)
                        }
                            }.frame(minHeight: 30)
                                .navigationDestination(isPresented: $navigate) {
                                    EditPersonalDetailsView()
                                }
                      
                            Rectangle().frame(height: 2).foregroundColor(.gray.opacity(0.2))
                            // MARK: - Change Password
                                Button {
                                    navigateToChangePassword.toggle()
                                } label: {
                                    HStack {
                                        Text(Constants.Buttons.changePassword)
                                        Spacer()
                                        Image(systemName: Constants.Icons.rightChevron)                    }
                                }.frame(minHeight: 30).fullScreenCover(isPresented: $navigateToChangePassword) {
                                    ChangePasswordView()
                                }
                            
                            Rectangle().frame(height: 2).foregroundColor(.gray.opacity(0.2))
                            
                            // MARK: - Phone verification
                                Button {
                                    navigateToPhoneVerification.toggle()
                                } label: {
                                    HStack {
                                        Text(Constants.Buttons.verifyNumber)
                                        Spacer()
                                        Image(systemName: Constants.Icons.rightChevron)
                                    }
                                }.frame(minHeight: 30).navigationDestination(isPresented: $navigateToPhoneVerification) {
                                    PhoneView()
                                }
                        }.padding(.horizontal).padding(.vertical,-5)
                        
                        Rectangle().frame(height: 20).foregroundColor(.gray.opacity(0.2))
                        
                        VStack(alignment: .leading, spacing: 15) {
                            Button {
                                navigateToRegisterVehicle.toggle()
                            } label: {
                                HStack {
                                    ProfileButtons(text: Constants.Buttons.addVehicle)
                                    Spacer()
                                }
                            }.navigationDestination(isPresented: $navigateToRegisterVehicle) {
                                RegisterVehicleView(isUpdateVehicle: .constant(false), hasUpdated: .constant(false))
                            }
                            
                            Rectangle().frame(height: 2).foregroundColor(.gray.opacity(0.2))
                            
                            Button {
                                navigateToAllVehiclePage.toggle()
                            } label: {
                                HStack {
                                    Text(Constants.Buttons.getVehicleInfo)
                                    Spacer()
                                    Image(systemName: Constants.Icons.rightChevron)
                                }
                            }
                            .frame(minHeight: 30)
                            .navigationDestination(isPresented: $navigateToAllVehiclePage) {
                                AllVehicleView()
                            }
                        }.padding(.horizontal)
                        
                        Rectangle().frame(height: 20).foregroundColor(.gray.opacity(0.2))
                        // MARK: - Logout Button
                        Button {
                            showAlert.toggle()
                            
                        }label: {
                                HStack {
                                    Text(Constants.Buttons.logout).foregroundColor(.red)
                                    Spacer()
                                }
                        }.padding(.leading)
                            .actionSheet(isPresented: $showAlert) {
                                ActionSheet(title: Text(""), message: Text("You sure you want to logout? "), buttons: [.destructive(Text("Logout"), action: {
                                    sessionManager.isLoggedIn.toggle()
                                    LoginSignUpViewModel.shared.currentState = .searchView
                                    vm.apiCall(forMethod: .logout)
                                }), .cancel()])
                            }
                            .alert(isPresented: $vm.failToLogout) {
                                Alert(title: Text(Constants.Alert.error), message: Text(ErrorAlert.logout.rawValue), dismissButton: .cancel())
                            }
                           
                    }
                    Rectangle().frame(height: 20).foregroundColor(.gray.opacity(0.2))
                }.refreshable {
                    vm.apiCall(forMethod: .getUser)
                }.scrollIndicators(.hidden)
            
                Spacer()
            }
            .onAppear {
                vm.apiCall(forMethod: .getUser)
            }
            .overlay(content: {
                if vm.isLoading {
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                }
            })
            .alert(isPresented: $vm.failToFetchUser) {
                Alert(title: Text(Constants.Alert.error),
                      message: Text(ErrorAlert.getUser.rawValue),
                      dismissButton: .cancel(Text(Constants.Buttons.ok)))
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
                .environmentObject(SessionManager()) // Inject the SessionManager environment object
                .environmentObject(BaseApiManager())
                .environmentObject(LoginSignUpViewModel())
    }
}
