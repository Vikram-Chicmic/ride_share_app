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
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: Constants.Icons.back).bold().font(.title)
                }.padding(.leading)
                Spacer()
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(vm.originData?.name ?? "")")
                        Image(systemName: Constants.Icons.arrowRight).foregroundColor(.green)
                        Text("\(vm.destinationData?.name ?? "")")
                    }.font(.headline)
                    Text("\(vm.date)  |  passenger").font(.subheadline)
                }.padding(.leading)
                Spacer()
            }.foregroundColor(.white).frame(height: 100).frame(maxWidth: .infinity).background(Constants.Colors.bluecolor)
            
            ScrollView {
                if let data = vm.searchRideResult {
                    ForEach(data.indices, id: \.self) { index in
                        CarPoolCard(data: data[index])
                            .onTapGesture {
                                self.selectedCardData = data[index]
                            navigate.toggle()
                        }
                    }.navigationDestination(isPresented: $navigate, destination: {
                        if let data = selectedCardData{
                            CarPoolDetailView(details: data)
                        }
                    }).scrollIndicators(.hidden).padding()
                }
            }
            Spacer()
        }.navigationBarBackButtonHidden(true).background {
            Color.gray.opacity(0.1).ignoresSafeArea()
        }
    }
}

//struct CarPoolView_Previews: PreviewProvider {
//    static var previews: some View {
//        CarPoolView(vm: MapAndSearchRideViewModel)
//    }
//}
