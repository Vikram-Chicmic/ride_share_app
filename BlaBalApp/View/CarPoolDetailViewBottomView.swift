//
//  CarPoolDetailViewBottomView.swift
//  BlaBalApp
//
//  Created by ChicMic on 26/05/23.
//

import SwiftUI

struct CarPoolDetailViewBottomView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Total price for 1 passenger")
                Spacer()
                Text("$30").font(.title2).bold()
            }.padding().background(
                Color.gray.opacity(0.1).cornerRadius(20)).padding(.vertical)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("John").font(.title3)
                    HStack {
                        Image(systemName: Constants.Icons.star)
                        Image(systemName: Constants.Icons.star)
                        Image(systemName: Constants.Icons.star)
                        Image(systemName: Constants.Icons.star)
                        Image(systemName: Constants.Icons.starHollow)
                        
                    }.foregroundColor(.yellow)
                }
                
                

                
                
                
                Spacer()
                Image("boy").resizable().frame(width: 50).clipShape(Circle()).scaledToFit()
            }.frame(height: 100).padding().background(
                Color.gray.opacity(0.1).cornerRadius(20)).padding(.vertical)
            
            Button {
                
            } label: {
                HStack {
                    Spacer()
                    Text("Contact John").font(.title3).bold()
                    Spacer()
                }
            }.padding(.vertical).background(
                Color.gray.opacity(0.1).cornerRadius(20))
            
        }
    }
}

struct CarPoolDetailViewBottomView_Previews: PreviewProvider {
    static var previews: some View {
        CarPoolDetailViewBottomView()
    }
}
