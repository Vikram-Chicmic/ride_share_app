//
//  CarPoolView.swift
//  BlaBalApp
//
//  Created by ChicMic on 25/05/23.
//

import SwiftUI

struct CarPoolView: View {
    @Environment(\.dismiss) var dismiss
    let carPoolCards = [1, 2, 3, 4, 5, 6, 7, 8]
    @State var navigate = false
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: Constants.Icons.back).bold().font(.title)
                }
               
                VStack(alignment: .leading) {
                    HStack {
                        Text("Mohali,Statdium")
                        Image(systemName: Constants.Icons.arrowRight).foregroundColor(.green)
                        Text("Bathinda, Punjab")
                    }.font(.headline)
                    Text("Mon 29 May,2023 | passenger").font(.subheadline)
                }.padding(.leading)
            }.foregroundColor(.white).frame(height: 100).frame(maxWidth: .infinity).background(Constants.Colors.bluecolor)
            
            ScrollView {
                ForEach(carPoolCards, id: \.self) { _ in
                    CarPoolCard().onTapGesture {
                        navigate.toggle()
                    }
                }.navigationDestination(isPresented: $navigate, destination: {
                    CarPoolDetailView()
                }).scrollIndicators(.hidden).padding()
            }
            
            Spacer()
        }.navigationBarBackButtonHidden(true).background {
            Color.gray.opacity(0.1).ignoresSafeArea()
        }
    }
}

struct CarPoolView_Previews: PreviewProvider {
    static var previews: some View {
        CarPoolView()
    }
}
