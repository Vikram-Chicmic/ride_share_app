////
////  ChooseLocationView.swift
////  BlaBalApp
////
////  Created by ChicMic on 12/05/23.
//
//
//import SwiftUI
//import MapKit
//
// struct LocationSearchView: View {
//     @StateObject var vm = MapViewModel()
//     @Environment(\.dismiss) var dismiss
//     var body: some View {
//         VStack {
//             HStack {
//                 Button {
//                     dismiss()
//                 } label: {
//                     Image(systemName: Constants.Icons.back).padding().font(.title2).foregroundColor(Constants.Colors.bluecolor)
//                 }
//                 Spacer()
//                 Text(Constants.Header.searchLocation).font(.title2).fontWeight(.semibold)
//                 Spacer()
//                 Spacer()
//                 
//                
//             }
//             HStack {
//                 Image(systemName: Constants.Icons.magnifyingGlass).foregroundColor(.gray).padding()
//                 TextField("Search Location here", text: $vm.searchText)
//             }.background {
//                 Color.gray.opacity(0.2).cornerRadius(25)
//             }.padding(.horizontal)
//             
//             if let places = vm.fetchedPlaces, !places.isEmpty {
//                 List {
//                     ForEach(places, id: \.self) { places in
//                         HStack {
//                             Image(systemName: Constants.Icons.location)
//                                 .font(.title2)
//                                 .foregroundColor(.gray)
//                             VStack(alignment: .leading) {
//                                 Text(places.name ?? "")
//                                     .font(.title3.bold())
//                                 Text(places.locality ?? "")
//                                     .font(.caption)
//                                     .foregroundColor(.gray)
//                             }.padding(.horizontal)
//                         }
//                         
//                         
//                         
//                     }
//                 }.listStyle(.plain)
//             } else {
//                 Button {
//                     
//                 } label: {
//                     HStack {
//                         Image(systemName: Constants.Icons.locationNorth).padding()
//                         Text("Use my current location")
//                         Spacer()
//                     }.foregroundColor(.green).font(.headline)
//                 }
//                 
//             }
//             Spacer()
//             
////             VStack {
////                 Map(coordinateRegion: $vm.region, showsUserLocation: true)
////                     .ignoresSafeArea()
////                     .accentColor(Color.pink)
////                     .onAppear{
////                         vm.checkIfLocationManagerIsEnabled()
////                     }
////             }
//         }
//         .navigationDestination(isPresented: .constant(true)) {
//           MapView()
//         }
//
//       
//     }
// }
//
// struct LocationSearchView_Previews: PreviewProvider {
//     static var previews: some View {
//         LocationSearchView()
//     }
// }
