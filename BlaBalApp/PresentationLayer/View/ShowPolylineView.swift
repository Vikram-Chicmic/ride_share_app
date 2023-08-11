import SwiftUI
import GoogleMaps

struct GoogleMapView: UIViewRepresentable {
    let polylineOverview: String
    let sourceCoordinate: CLLocationCoordinate2D
    let destinationCoordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: sourceCoordinate.latitude,
                                              longitude: sourceCoordinate.longitude,
                                              zoom: 12)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        uiView.clear()
        
        // Add source marker
        let sourceMarker = GMSMarker(position: sourceCoordinate)
        sourceMarker.icon = UIImage(named: "mappin")?.withTintColor(.blue) // Set your custom image
        sourceMarker.map = uiView
        
        // Add destination marker
        let destinationMarker = GMSMarker(position: destinationCoordinate)
        destinationMarker.icon = UIImage(named: "flag.fill")?.withTintColor(.green) // Set your custom image
        destinationMarker.map = uiView
        
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




