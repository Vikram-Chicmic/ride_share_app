//
//  PolyLineView.swift
//  BlaBalApp
//
//  Created by ChicMic on 11/08/23.
//
import SwiftUI
import CoreLocation

struct ShowPolylineView: View {
    let polylineOverview = MapAndRidesViewModel.shared.polylineString
    @EnvironmentObject var vm: MapAndRidesViewModel
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var networkStatusManager: NetworkStatusManager
    @State var alertNow = false
    var body: some View {
        VStack(alignment: .leading) {
            let sourceCoordinate = CLLocationCoordinate2D(latitude: vm.originData?.geometry.location.lat ?? 0.0,
                                                          longitude: vm.originData?.geometry.location.lng ?? 0.0)
            let destinationCoordinate = CLLocationCoordinate2D(latitude: vm.destinationData?.geometry.location.lat ?? 0.0,
                longitude: vm.destinationData?.geometry.location.lng ?? 0.0)
                    
            GoogleMapView(polylineOverview: polylineOverview, sourceCoordinate: sourceCoordinate, destinationCoordinate: destinationCoordinate)
                .edgesIgnoringSafeArea(.top).edgesIgnoringSafeArea(.horizontal).frame(height: UIScreen.main.bounds.height/2.5)
            Text("Details ").font(.title2).padding(.top).padding(.leading).fontWeight(.semibold)
            VStack(alignment: .leading, spacing: 5) {
                RideDetailTileView(title: "Source", value: vm.originData?.name ?? "Can't find name")
                RideDetailTileView(title: "Destination", value: vm.destinationData?.name ?? "Can't find name")
                RideDetailTileView(title: "No of seats", value: String(vm.passengers))
                RideDetailTileView(title: "Date", value: vm.date)
                RideDetailTileView(title: "Time", value: vm.time)
                RideDetailTileView(title: "Price", value: vm.amount)
                RideDetailTileView(title: "Estimated Time", value: vm.estimatedTime)
            }.padding().background {
                Color.gray.opacity(0.1).cornerRadius(10)
            }.padding(.horizontal)
                
            Spacer()
            Button {
                
                
                
                let time = toConvertDate(seconds: vm.estimatedTimeInSeconds ?? 10)
                print("Time format: \(time)")
                vm.estimatedTime = time
                vm.isUpdatedSource = true
                vm.isUpdatedDestination = true
                vm.alertSuccess = false
                vm.apiCall(for: .publishRide)
            } label: {
                Buttons(image: "", text: "Publish Ride", color: Constants.Colors.bluecolor)
            }.padding().onChange(of: vm.alertForPublish, perform: { _ in
                    alertNow.toggle()
                })
                .alert(isPresented: $alertNow) {
                    Alert(title:
                            vm.alertSuccess ? Text(Constants.Alert.success) :  Text(Constants.Alert.failToPublishRide),
                        message:
                            vm.alertSuccess ?  Text(SuccessAlerts.publishRide.rawValue) : Text(ErrorAlert.publishRide.rawValue),
                          dismissButton: .cancel(Text(Constants.Buttons.ok), action: {
                        vm.alertSuccess ? dismiss() : nil
                    }))
                }
        }.overlay(
            VStack {
                if vm.isLoading {
                    Spacer() // Push the ProgressView to the top
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                }
                Spacer() // Push the following content to the bottom
                if vm.showToast {
                    CustomAlert(text: vm.toastMessage, dismiss: $vm.showToast)
                        .onAppear {
                            // Automatically hide the toast message after a delay
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    vm.showToast = false
                                }
                            }
                        }
                        .animation(.default)
                }
            }
        )

        .navigationTitle("Publish Ride")
            .onAppear {
        }
    }
    
    func toConvertDate(seconds: Int) -> String {
        let hours =  seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        return "\(hours):\(minutes):\(seconds)"
    }
}

struct ShowPolylineView_Previews: PreviewProvider {
    static var previews: some View {
        ShowPolylineView().environmentObject(MapAndRidesViewModel())
    }
}
