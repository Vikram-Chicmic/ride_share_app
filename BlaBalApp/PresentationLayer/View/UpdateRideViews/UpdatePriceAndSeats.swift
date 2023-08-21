//
//  UpdatePriceAndSeats.swift
//  BlaBalApp
//
//  Created by ChicMic on 07/07/23.
//

import SwiftUI

struct UpdatePriceAndSeats: View {
    @EnvironmentObject var vm: MapAndRidesViewModel
    @FocusState var isFocused: Bool
    @EnvironmentObject var networkStatusManager: NetworkStatusManager
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            // MARK: - Amount
            HStack {
                Image(systemName: Constants.Icons.rupeeSign).font(.title2).foregroundColor(.blue).bold().padding([.leading, .top])
                    HStack {
                       
                        TextField(Constants.Placeholders.enterAmount, text: $vm.amount).padding(.horizontal).keyboardType(.numberPad).focused($isFocused)
                    }.padding().background(content: {
                        Color.gray.opacity(0.22).cornerRadius(25)
                    }).padding(.horizontal).padding(.top)
            }.padding(.top)
         
            
            // MARK: - Seats
                HStack {
                    Image(systemName: Constants.Icons.seat).font(.title2).foregroundColor(.blue).padding([.top]).bold()
                       HStack {
                        Image(systemName: Constants.Icons.minuscircle).font(.title2).foregroundColor(vm.passengers == 1 ? .gray : Constants.Colors.bluecolor).disabled(vm.passengers<1).onTapGesture {
                            if vm.passengers>1 {
                                vm.passengers-=1
                            }
                        }
                        Spacer()
                        Text("\(vm.passengers)").font(.title2).bold()
                        Spacer()
                        Image(systemName: Constants.Icons.pluscircle).font(.title2).foregroundColor(vm.passengers==8 ? .gray : Constants.Colors.bluecolor).onTapGesture {
                            if vm.passengers<8 {
                                vm.passengers+=1
                            }
                        }
                       }.frame(height: 23).padding().background(content: {
                        Color.gray.opacity(0.22).cornerRadius(25)
                    }).padding(.horizontal).padding(.top)
                        .padding(.leading, 6)
                }.padding(.leading)
            
            Button {
                vm.isUpdatedSource = vm.originData != nil ? true :  false
                vm.isUpdatedDestination =  vm.destinationData != nil ? true : false
                vm.apiCall(for: .updateRide)
            } label: {
                Buttons(image: "", text: Constants.Texts.update, color: (vm.amount.isEmpty) ? .gray : Constants.Colors.bluecolor).padding()
            }.alert(isPresented: $vm.updateRideSuccess) {
                Alert(title: Text(Constants.Alert.success), message: Text(SuccessAlerts.updateRide.rawValue), dismissButton: .cancel(Text(Constants.Buttons.ok), action: {
                    dismiss()
                }))
            }.disabled(vm.amount.isEmpty)
            Spacer()
        }.navigationTitle("Update Price and Seats")
    }
}

struct UpdatePriceAndSeats_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePriceAndSeats().environmentObject(MapAndRidesViewModel())
    }
}
