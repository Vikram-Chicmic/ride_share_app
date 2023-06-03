//
//  CarPoolDetailView.swift
//  BlaBalApp
//
//  Created by ChicMic on 26/05/23.
//

import SwiftUI

struct CarPoolDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var viewHeight: CGFloat = 0
    @State var secondViewHeight: CGFloat = 0
    @State var progressHeight: CGFloat = 0
    var details: SearchRideResponseData
    var body: some View {
                VStack(alignment: .leading) {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: Constants.Icons.back).fontWeight(.semibold).font(.title)
                        }
                        Spacer()
                    }
                   
                    Text("\(Helper().dateFormatter(date: details.reachTime))").bold().font(.title).padding().padding(.vertical)
                  
               
                        GeometryReader { geometry in
                            VStack(alignment: .leading, spacing: 20) {
                                
                                    HStack(alignment: .top, spacing: 50) {
                                        Text("06:00").bold()
                                        CarPoolCardSubView(place: "\(details.publish.source)", location: "Sahibzada Ajit Singh Nagar", distance: "2.4 km from your location")
                                    }.overlay(alignment: .leading) {
                                        VStack {
                                            Spacer()
                                                ProgressView( value: 50, total: 100)
                                                .frame(width: (viewHeight - secondViewHeight) + 5.0)
                                                    .rotationEffect(Angle(degrees: 90))
                                        }.frame(width: 10).padding(.leading, 70)
                                    }


                                Text("4h20").opacity(0.7).font(.subheadline)
                                    GeometryReader { geo in
                                                HStack(alignment: .top, spacing: 50) {
                                                    Text("06:00").bold()
                                                    CarPoolCardSubView(place: "\(details.publish.destination)", location: "Sahibzada Ajit Singh Nagar", distance: "2.4 km from your location")
                                                }
                                                .onAppear {
                                                    secondViewHeight = geo.size.height
                                              }
                                    }

                            }
                            .onAppear {
                                viewHeight = geometry.size.height
                          }
                        }
                   
                  
        //            Spacer()
                    CarPoolDetailViewBottomView()
                }.navigationBarBackButtonHidden(true).padding()
            
        
    }
}
//
//struct CarPoolDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CarPoolDetailView()
//    }
//}
