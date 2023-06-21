
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
    
    var body: some View {
        GoogleMapView(polylineOverview: polylineOverview)
            .edgesIgnoringSafeArea(.all)
    }
}

