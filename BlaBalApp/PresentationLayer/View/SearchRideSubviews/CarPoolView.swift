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
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: Constants.Icons.back).bold().font(.title)
                    }.padding(.leading)
                    Spacer()
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
                        
                        HStack {
                            Spacer()
                            Text("\(vm.date)").font(.subheadline)
                            Spacer()
                        }
                    }
                  
                    Spacer()
                }.foregroundColor(.white).frame(height: 100).frame(maxWidth: .infinity).background {
                    Image("download")
                               .resizable()
                               .mask(BottomCornerRadiusShape(cornerRadius: 10)).overlay {
                        TransparentBlurView(removeAllFilters: false).mask(BottomCornerRadiusShape(cornerRadius: 0))
                    }
            }
                
                ScrollView {
                    if let data = vm.searchRideResult {
                        if data.count > 0 {
                            ForEach(data.indices, id: \.self) { index in
                                CarPoolCard(data: data[index])
                                    .onTapGesture {
                                        self.selectedCardData = data[index]
                                        navigate.toggle()
                                    }
                            }.navigationDestination(isPresented: $navigate, destination: {
                                if let data = selectedCardData {
                                    CarPoolDetailView(details: data)
                                }
                            }).scrollIndicators(.hidden).padding()
                        } else {
                            VStack {
                                Spacer()
                                Image("carPool1").resizable().scaledToFit().opacity(0.9)
                                Text("No rides found").foregroundColor(.white).font(.title).bold()
                                Spacer()
                            }
                        }
                    }
                }.padding(.horizontal)
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


