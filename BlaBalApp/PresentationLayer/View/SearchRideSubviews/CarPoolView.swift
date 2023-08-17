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
    @EnvironmentObject var vm: MapAndRidesViewModel
    @State var navigate = false
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image(systemName: Constants.Icons.back)
                        .bold()
                        .font(.title3)
                        .foregroundColor(.gray)
                        .onTapGesture {
                            dismiss()
                        }
                    
                    VStack(alignment: .center,spacing: 5) {
                        HStack {
                            Text("\(vm.originData?.name ?? "")")
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                                .lineLimit(2) // Allow a maximum of two lines
                                .frame(minWidth: 0, maxWidth: .infinity) // Expand to fill available space
                            
                            Image(systemName: Constants.Icons.arrowRight)
                                .foregroundColor(.gray)
                            
                            Text("\(vm.destinationData?.name ?? "")")
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                                .lineLimit(2) // Allow a maximum of two lines
                                .frame(minWidth: 0, maxWidth: .infinity) // Expand to fill available space
                        }
                        Text("\(Helper().formatDateToMMM(vm.date, dateFormat: Constants.Date.dateFormat))").foregroundColor(.gray).font(.subheadline)
                    }.padding()
                    
                     // Hide the placeholder image
                }
                .frame(maxHeight: 40)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
    
                    if let data = vm.searchRideResult {
                        if data.count > 0 {
                            ScrollView {
                            ForEach(data.indices, id: \.self) { index in
                                CarPoolCard(data: data[index]).padding([.horizontal, .top])
                                    .onTapGesture {
                                        self.selectedCardData = data[index]
                                        navigate.toggle()
                                    }
                            }.navigationDestination(isPresented: $navigate, destination: {
                                if let data = selectedCardData {
                                    RideDetailView(details: data)
                                }
                            })
                        }.scrollIndicators(.hidden)
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
            .environmentObject(MapAndRidesViewModel())
    }
}
