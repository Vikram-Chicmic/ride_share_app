//
//  SwiftUIView.swift
//  BlaBalApp
//
//  Created by ChicMic on 25/05/23.
//

import SwiftUI

struct CarPoolCard: View {
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("06:00").bold()
                    Text("4h20").opacity(0.7).font(.subheadline)
                    Text("10:20").bold()
                }.padding(.trailing)
                
                VStack(alignment: .leading) {
                    Text("Chandigarh").bold()
                    HStack {
                        Image(systemName: "figure.walk").foregroundColor(.green)
                        Image(systemName: "figure.walk")
                        Image(systemName: "figure.walk")
                    }.padding(.bottom)
                    
                    Text("Bathinda").bold()
                    HStack {
                        Image(systemName: "figure.walk")
                        Image(systemName: "figure.walk").foregroundColor(.green)
                        Image(systemName: "figure.walk")
                    }
                }
                Spacer()
                Text("$46.00").font(.title3).bold()
                
            }.padding()
            
            HStack {
                Image("boy").resizable().frame(width: 50, height: 50).scaledToFit().clipShape(Circle())
                    .padding(.trailing, 15)
                Text("John").font(.system(size: 20))
                Spacer()
                Image(systemName: "paperplane").font(.title2)
                Image(systemName: "heart").font(.title2)
            }.padding(.bottom)
                .padding(.horizontal)
           
            
        }.background {
            Color.white.cornerRadius(20)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 20).strokeBorder().foregroundColor(.gray).shadow(color: .gray, radius: 1)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CarPoolCard()
    }
}
