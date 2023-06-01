//
//  NameView.swift
//  BlaBalApp
//
//  Created by ChicMic on 12/05/23.
//

import SwiftUI

struct NameView: View {
    @ObservedObject var vm: LoginSignUpViewModel
    @State var navigate: Bool = false
    @State var alert: Bool =  false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            VStack {
                CustomProgressBar(step: $vm.step)
                NavigationStack {
                    VStack(alignment: .leading) {
                            Text(Constants.Titles.name).font(.title).fontWeight(.semibold).padding(.vertical).padding(.bottom, 40)
                        CustomTextfield(label: Constants.Labels.fname, placeholder: Constants.Placeholders.fname, value: $vm.fname)
                            CustomTextfield(label: Constants.Labels.lname, placeholder: Constants.Placeholders.lname, value: $vm.lname)
                

                            Button {
                                if vm.lname.isEmpty || vm.fname.isEmpty {
                                    alert = true
                                } else {
                                withAnimation {
                                    vm.step += 1
                                }
                                    navigate.toggle()
                                }
                            }label: {
                                Buttons(image: "", text: Constants.Buttons.cont, color: .blue).padding(.top)
                            }
                    

                            Spacer()
                            
                            if alert {
                                CustomAlert(text: Constants.Alert.emptyfield, dismiss: $alert)
                               }
                  
                        }
                        .onAppear {
                            withAnimation {
                                vm.step = 0
                            }
                        }
                        .padding()
                        .navigationDestination(isPresented: $navigate) {
                            BirthdayView(vm: vm)
                                .transition(.opacity)
                                .navigationBarBackButtonHidden()
                    }
                }.environmentObject(vm)
            }.padding(.vertical)
        }
    }
}

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView(vm: LoginSignUpViewModel())
    }
}
