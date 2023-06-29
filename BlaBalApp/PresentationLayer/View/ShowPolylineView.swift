
import SwiftUI
import GoogleMaps

struct GoogleMapView: UIViewRepresentable {
    let polylineOverview: String
    
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 12)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        uiView.clear()
        
        let path = GMSPath(fromEncodedPath: polylineOverview)
        
        if let path = path {
            let polyline = GMSPolyline(path: path)
            polyline.strokeWidth = 4.0
            polyline.strokeColor = UIColor.blue
            polyline.map = uiView
            
            let bounds = GMSCoordinateBounds(path: path)
            let update = GMSCameraUpdate.fit(bounds, withPadding: 50)
            uiView.animate(with: update)
        }
    }
}

struct ShowPolylineView: View {
    let polylineOverview = MapAndSearchRideViewModel.shared.polylineString
    @EnvironmentObject var vm: MapAndSearchRideViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            GoogleMapView(polylineOverview: polylineOverview)
                .edgesIgnoringSafeArea(.top).edgesIgnoringSafeArea(.horizontal).frame(height: UIScreen.main.bounds.height/2.5)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Details :").font(.title2).padding(.bottom, 5)
                RideDetailTileView(title: "Source", value: vm.originData?.name ?? "Can't find name")
                RideDetailTileView(title: "Destination", value: vm.destinationData?.name ?? "Can't find name")
                RideDetailTileView(title: "No of seats", value: String(vm.passengers))
                RideDetailTileView(title: "Date", value: vm.date)
                RideDetailTileView(title: "Time", value: vm.time)
                RideDetailTileView(title: "Price", value: vm.amount)
                RideDetailTileView(title: "Estimated Time", value: vm.estimatedTime)
            }.padding().background {
                Image("Bank")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .frame(height: 250)
                    .overlay {
                        TransparentBlurView(removeAllFilters: false).cornerRadius(20)
                }
            }.padding()
            Spacer()
            Button {
                let time = toConvertDate(seconds: vm.estimatedTimeInSeconds ?? 10)
                print("Time format: \(time)")
                vm.estimatedTime = time
                vm.apiCall(for: .publishRide)
            } label: {
                Buttons(image: "", text: "Publish Ride", color: Constants.Colors.bluecolor)
            }.padding()
                
                .actionSheet(isPresented: $vm.alertSuccess) {
                    
                    ActionSheet(title: Text(""), message: Text(SuccessAlerts.publishRide.rawValue), buttons: [.cancel(
                        Text(Constants.Buttons.ok), action: {
                            dismiss()
                        }
                    )])

                    
//                   Alert(title: Text(Constants.Alert.success), message: Text(SuccessAlerts.publishRide.rawValue), dismissButton: .cancel(Text(Constants.Buttons.ok), action: {
//                       dismiss()
//                   }))
               }
               .alert(isPresented: $vm.alertFailure) {
                   Alert(title: Text(Constants.Alert.error), message: Text(ErrorAlert.publishRide.rawValue), dismissButton: .cancel(Text(Constants.Buttons.ok)))
               }
               
        }.navigationTitle("Publish Ride")
            .onAppear {
                print(
                vm.estimatedTimeInSeconds
            )
            
            
            
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
        ShowPolylineView().environmentObject(MapAndSearchRideViewModel())
    }
}

