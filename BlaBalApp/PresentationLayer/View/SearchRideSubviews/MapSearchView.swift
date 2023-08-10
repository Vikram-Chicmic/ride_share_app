//
//  MapView.swift
//  BlaBalApp
//
//  Created by ChicMic on 25/05/23.
//

import SwiftUI

struct MapSearchView: View {
    @EnvironmentObject var vm: MapAndRidesViewModel
    @StateObject var locationViewModel = LocationViewModel()
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
            if vm.searchText == "" {
//                Button {
//                    switch locationViewModel.authorizationStatus {
//                                            case .authorizedAlways, .authorizedWhenInUse:
//                                                locationViewModel.startLocationUpdation()
//                                            default:
//                                                locationViewModel.requestPermission()
//                                            }
//                } label: {
//                    HStack {
//                        Spacer()
//                        HStack {
//                            Image(systemName: "location.north").foregroundColor(.green).font(.subheadline)
//                            Text("Use current location")
//                        }.padding(10).background(content: {
//                            Color.gray.opacity(0.3).cornerRadius(10)
//                        }).padding(.horizontal)
//                    }
//                  
//                   
//                }.padding(.top)
            }
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
                        }.listRowSeparator(.hidden)
                            .onTapGesture {
                            if isOrigin {
                                vm.originData = dataArr[index]
                            } else {
                                vm.destinationData = dataArr[index]
                            }
                           
                            dismiss()
                        }
                    }
                }
            }.listStyle(.plain)
            Spacer()
        }.onAppear {
            // fetch history from user defauts , upto 3 locations
            vm.searchText = ""
            vm.searchResultArr = nil
        }.onDisappear {
            isOrigin = true
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapSearchView( isOrigin: .constant(true)).environmentObject(MapAndRidesViewModel())
    }
}


