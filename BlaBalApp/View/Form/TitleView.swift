//
//  TitleView.swift
//  BlaBalApp
//
//  Created by ChicMic on 12/05/23.
//

import SwiftUI

struct TitleView: View {
    @ObservedObject var vm: LoginSignUpViewModel
    @State var navigate: Bool = false
    @State var alert: Bool = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(Constants.Titles.title).font(.title).fontWeight(.semibold).padding(.bottom, 40)
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
            
            Button {
                if vm.selectedTitle.isEmpty {
                    alert = true
                } else {
                    navigate.toggle()
                    
                    withAnimation {
                        vm.step += 1
                    }
                }
            } label: {
                Buttons(image: "", text: Constants.Buttons.cont, color: .blue).padding(.top)
                 }
            Button {
                dismiss()
            } label: {
                Buttons(image: "", text: Constants.Buttons.back, color: Color(red: 0.742, green: 0.742, blue: 0.754))
            }
          Spacer()
            if alert {
                CustomAlert(text: Constants.Alert.emptyfield, dismiss: $alert)
            }
        }
        
        .onAppear {
            withAnimation {
                vm.step = 2
            }
        }
        .padding()
            .navigationDestination(isPresented: $navigate) {
                PhoneView(vm: vm).navigationBarBackButtonHidden()
            }
        
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(vm: LoginSignUpViewModel())
    }
}
