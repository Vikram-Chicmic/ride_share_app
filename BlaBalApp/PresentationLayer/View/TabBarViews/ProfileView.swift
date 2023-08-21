//
//  ProfileView.swift
//  BlaBalApp
//
//  Created by ChicMic on 11/05/23.
//

import SwiftUI

struct ProfileView: View {
    @State var navigateToEditDetail: Bool = false
    @State var navigateToPhoneVerification: Bool = false
    @EnvironmentObject var networkStatusManager: NetworkStatusManager
    @State var detail: Welcome?
    @State var showAlert: Bool = false
    @EnvironmentObject var vm: LoginSignUpViewModel
    @State var navigateToAllVehiclePage = false
    @State var navigateToChangePassword = false
    @Environment(\.colorScheme) var colorScheme
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
                        Rectangle().frame(height: 10).foregroundColor(.gray.opacity(0.2))
                    }
                    VStack(alignment: .leading, spacing: 15) {
                        Section {
                            Text(Constants.Header.yourProfile).font(.title2).fontWeight(.semibold).padding(.leading)
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    ProfileDetailTileView(image: Constants.Icons.phone, value: vm.recievedData?.status.data?.phoneNumber ?? Constants.DefaultValues.noPhone)
                                    if let verified = vm.decodedData?.user.phoneVerified {
                                        if verified {
                                            Image(systemName: "checkmark.seal.fill").frame(width: 20, height: 20).foregroundColor(.green)
                                        } else {
                                            Image(systemName: "exclamationmark.triangle.fill").frame(width: 20, height: 20).foregroundColor(.yellow)
                                        }
                                    }
                                }
                                ProfileDetailTileView(image: Constants.Icons.mail, value: vm.recievedData?.status.data?.email ?? "")
                                ProfileDetailTileView(image: Constants.Icons.calander, value: vm.recievedData?.status.data?.dob ?? Constants.DefaultValues.bday)
                                ProfileDetailTileView(image: Constants.Icons.personText, value: vm.recievedData?.status.data?.bio ?? Constants.DefaultValues.bio)
                            }.padding(.leading)
                        }
                        
                        Rectangle().frame(height: 10).foregroundColor(.gray.opacity(0.2))
                        
                        VStack {
                                    ProfileOptionButton( label: Text(Constants.Buttons.editprofile), destination: EditPersonalDetailsView(),isPresented: $navigateToEditDetail)
                                    Rectangle().frame(height: 2).foregroundColor(.gray.opacity(0.2))
                                    ProfileOptionButton(label: Text(Constants.Buttons.changePassword), destination: ChangePasswordView(),isPresented: $navigateToChangePassword)
                                    Rectangle().frame(height: 2).foregroundColor(.gray.opacity(0.2))
                                    ProfileOptionButton(label: Text(Constants.Buttons.verifyNumber),destination: PhoneView(),isPresented: $navigateToPhoneVerification)
                                }
                                .padding(.horizontal)
                                .padding(.vertical, -5)
                        
                        Rectangle().frame(height: 10).foregroundColor(.gray.opacity(0.2))
                        
                        VStack {
                            Button {
                                navigateToAllVehiclePage.toggle()
                            } label: {
                                HStack {
                                    Text(Constants.Buttons.getVehicleInfo)
                                    Spacer()
                                    Image(systemName: Constants.Icons.rightChevron)
                                }
                            }.foregroundColor(colorScheme == .dark ? .white : .black)
                            .frame(minHeight: 30)
                            .navigationDestination(isPresented: $navigateToAllVehiclePage) {
                                AllVehicleView()
                            }
                        }.padding(.horizontal)
                        Rectangle().frame(height: 10).foregroundColor(.gray.opacity(0.2))
                        // MARK: - Logout Button
                        Button {
                            showAlert.toggle()
                        }label: {
                                HStack {
                                    Text(Constants.Buttons.logout)
                                    Spacer()
                                    Image(systemName: Constants.Icons.rightChevron).padding(.trailing)
                                   
                                }
                        }.foregroundColor(.red).padding(.leading)
                            .actionSheet(isPresented: $showAlert) {
                                ActionSheet(title: Text(""), message: Text("You sure you want to logout? "), buttons: [.destructive(Text("Logout"), action: {
                                    vm.apiCall(forMethod: .logout)
                                }), .cancel()])
                            }
                           
                            .alert(isPresented: $vm.failToLogout) {
                                Alert(title: Text(Constants.Alert.error), message: Text(ErrorAlert.logout.rawValue), dismissButton: .cancel())
                            }
                    }
                   
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
