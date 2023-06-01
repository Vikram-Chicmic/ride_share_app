//
//  LocationView.swift
//  BlaBalApp
//
//  Created by ChicMic on 10/05/23.
//

import SwiftUI

struct LocationView: View {
    @State var startPoint: String = ""
    @State var addSeatNavigate: Bool = false
    @State var seats: Int = 1
    @State var openCalendar: Bool = false
    @State private var selectedDate = Date()
    @State var showMapView = false
    @State var showCarPoolView = false
    var body: some View {
        
            VStack {
                // MARK: - Start From
                Button {
                    showMapView.toggle()
                }label: {
                    HStack(spacing: 30) {
                        Image(systemName: Constants.Icons.circle).bold().padding(.leading).foregroundColor(.blue)
                        Text(Constants.Buttons.startfrom).foregroundColor(.black)
                        Spacer()
                    }
                }.sheet(isPresented: $showMapView, content: {
                    LocationSearchView()
                })
                .padding(.top, 4)
                .frame(height: 45)
                Divider().padding(.horizontal)
                // MARK: - Going to
                Button {
                } label: {
                    HStack(spacing: 30) {
                        Image(systemName: Constants.Icons.location).bold().padding(.leading).foregroundColor(.blue)
                        Text(Constants.Buttons.goingto).foregroundColor(.black)
                        Spacer()
                    }
                }.frame(height: 40)
                Divider().padding(.horizontal)
                // MARK: - Calendar
                HStack {
                    Button {
                        openCalendar = true
                    } label: {
                        HStack(spacing: 20) {
                            Image(systemName: Constants.Icons.calander).font(.title2).padding(.leading)
                            Text("\(selectedDate, formatter: DateFormatter.custom)").foregroundColor(.black)
                            Spacer()
                        }.padding(.trailing, 10).frame(height: 40)
                    }.sheet(isPresented: $openCalendar) {
                        CalendarView(selectedDate: $selectedDate, isDob: .constant(false))
                    }
                    Divider().frame(height: 40).padding(.horizontal)
                    // MARK: - Seats
                    Button {
                        addSeatNavigate.toggle()
                    } label: {
                        HStack {
                            Image(systemName: Constants.Icons.person).font(.title2)
                            Text("\(seats)").font(.title2).foregroundColor(.black)
                        }
                    }.padding(.trailing, 40)
                }.sheet(isPresented: $addSeatNavigate) {
                    AddSeatView(seat: $seats, temp: seats)
                }
                // MARK: - Search
                
                Button {
                
                        showCarPoolView.toggle()
                    
                } label: {
                    HStack {
                        Spacer()
                        Text(Constants.Labels.search)
                        Spacer()
                    }.frame(height: 50).background(.blue).foregroundColor(.white)
                }.navigationDestination(isPresented: $showCarPoolView, destination: {
                    
                    CarPoolView().transition(.opacity)
                })
    //            .fullScreenCover(isPresented: $showCarPoolView) {
    //                CarPoolView()
    //            }
            }.background(.white).cornerRadius(20).shadow(color: .gray, radius: 20)
        
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
