//
//  TitleView.swift
//  BlaBalApp
//
//  Created by ChicMic on 12/05/23.
//

import SwiftUI

struct TitleView: View {
    @EnvironmentObject var vm: LoginSignUpViewModel
    @State var navigate: Bool = false
    @Binding var alert: Bool
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(Constants.Titles.title).font(.title).fontWeight(.semibold).padding(.bottom, 40)
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
            Spacer()
            if alert {
                CustomAlert(text: Constants.Alert.emptyfield, dismiss: $alert)
            }
        }
        
        .onAppear {
            vm.isUpdating = false
            print(vm.bday, vm.email, vm.password, vm.fname, vm.lname, vm.selectedTitle)
        }
        .padding()
        .navigationDestination(isPresented: $vm.navigate) {
              TabBarView().navigationBarBackButtonHidden()
            }
        
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(alert: .constant(false)).environmentObject(LoginSignUpViewModel())
    }
}
