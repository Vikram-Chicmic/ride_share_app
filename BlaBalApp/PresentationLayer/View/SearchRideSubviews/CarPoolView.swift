//
//  CarPoolView.swift
//  BlaBalApp
//
//  Created by ChicMic on 25/05/23.
//

import SwiftUI

struct CarPoolView: View {
    @Environment(\.dismiss) var dismiss
    @State var selectedCardData: SearchRideResponseData?
    @EnvironmentObject var vm: MapAndSearchRideViewModel
    @State var navigate = false
    var body: some View {
        ZStack {
            VStack {
               
                    RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 1).foregroundColor(Color.cyan).frame(height: 55).padding(.horizontal).overlay {
                        HStack {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: Constants.Icons.back).bold().font(.title2).foregroundColor(.cyan)
                            }.padding(.leading,30)
                            VStack {
                                HStack {
                                    Spacer()
                                    Text("\(vm.originData?.name ?? "")").font(.headline)
                                    Spacer()
                                    Image(systemName: Constants.Icons.arrowRight).foregroundColor(.green)
                                    Spacer()
                                    Text("\(vm.destinationData?.name ?? "")").font(.headline)
                                    Spacer()
                                }
                            }
                          
                            Spacer()
                        }.frame(height: 100)
                    }
                
              
          
                
               
                    if let data = vm.searchRideResult {
                        if data.count > 0 {
                            ScrollView {
                            ForEach(data.indices, id: \.self) { index in
                                CarPoolCard(data: data[index]).padding(.vertical)
                                    .onTapGesture {
                                        self.selectedCardData = data[index]
                                        navigate.toggle()
                                    }
                            }.navigationDestination(isPresented: $navigate, destination: {
                                if let data = selectedCardData {
                                    RideDetailView(details: data)
                                }
                            }).scrollIndicators(.hidden).padding()
                        }
                    } else {
                        VStack {
                            Spacer()
                            Image("carsaf").resizable().scaledToFit().frame(width: 200).opacity(0.9)
                            Text("No rides found").foregroundColor(.white).font(.title).bold()
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct CarPoolView_Previews: PreviewProvider {
    static var previews: some View {
        CarPoolView()
            .environmentObject(MapAndSearchRideViewModel())
    }
}


