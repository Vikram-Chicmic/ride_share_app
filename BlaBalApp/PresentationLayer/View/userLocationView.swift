import SwiftUI
import GoogleMaps
import CoreLocation

struct CustomMapView: UIViewRepresentable {
    @ObservedObject var locationManager = CustomLocationManager()
    let mapView = GMSMapView()

    func makeUIView(context: Context) -> GMSMapView {
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.delegate = context.coordinator
        locationManager.mapView = mapView

        return mapView
    }

    func updateUIView(_ mapView: GMSMapView, context: Context) {
        // Update the map view if needed
    }

    func makeCoordinator() -> CustomCoordinator {
        CustomCoordinator(self)
    }

    class CustomCoordinator: NSObject, GMSMapViewDelegate {
        var parent: CustomMapView

        init(_ parent: CustomMapView) {
            self.parent = parent
        }

        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
            // Handle marker tap if needed
            return true
        }
    }
}

class CustomLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    weak var mapView: GMSMapView?

    override init() {
        super.init()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 14.0)
        DispatchQueue.main.async {
            self.mapView?.animate(to: camera)
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(" error: \(error.localizedDescription)")
    }
}

struct Content1View: View {
    var body: some View {
        VStack {
            CustomMapView()
                .edgesIgnoringSafeArea(.all)
                .frame(height: 300)
        }
    }
}

struct Content1View_Previews: PreviewProvider {
    static var previews: some View {
        Content1View()
    }
}
