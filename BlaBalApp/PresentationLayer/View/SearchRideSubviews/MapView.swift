//
//  MapView.swift
//  BlaBalApp
//
//  Created by ChicMic on 25/05/23.
//

import SwiftUI

struct MapView: View {
    @EnvironmentObject var vm: MapAndSearchRideViewModel
    @Binding var isOrigin: Bool
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
           
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: Constants.Icons.back).padding().font(.title2).foregroundColor(Constants.Colors.bluecolor)
                }
                Spacer()
                Text(isOrigin ? Constants.Header.startLocation : Constants.Header.destinationLocation ).font(.title2).fontWeight(.semibold)
                Spacer()
                Spacer()
                
               
            }
                
            HStack {
                Image(systemName: Constants.Icons.magnifyingGlass).foregroundColor(.gray).padding()
                TextField(Constants.Placeholders.searchHere, text: $vm.searchText).onChange(of: vm.searchText) { _ in
                    vm.apiCall(for: .fetchPlaces)
                }
            }.background {
                Color.gray.opacity(0.2).cornerRadius(25)
            }.padding(.horizontal)
            List {
                if let dataArr = vm.searchResultArr?.results {
                    ForEach((dataArr.indices), id: \.self) { index in
                        HStack(spacing: 20) {
                            Image(systemName: Constants.Icons.location)
                                .font(.title2)
                                .foregroundColor(.gray)
                            VStack(alignment: .leading) {
                                Text(dataArr[index].name)
                                Text(dataArr[index].formattedAddress).font(.system(size: 12))
                            }.frame(height: 80)
                        }.onTapGesture {
                            if isOrigin {
                                vm.originData = dataArr[index]
                            } else {
                                vm.destinationData = dataArr[index]
                            }
                           
                            dismiss()
                        }
                    }
                } else {}
                    
                
            }.listStyle(.plain)
            
            Spacer()
        }.onAppear {
            vm.searchText = ""
            vm.searchResultArr = nil
        }.onDisappear {
            isOrigin = true
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView( isOrigin: .constant(true)).environmentObject(MapAndSearchRideViewModel())
    }
}


