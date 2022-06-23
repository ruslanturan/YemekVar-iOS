//
//  LocationManager.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 19.04.22.
//
import Foundation
import CoreLocation
import GoogleMaps

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocation?
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastKnownLocation: CLLocation?
    
    func startUpdating() {
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
        self.manager.desiredAccuracy = kCLLocationAccuracyBest

    }
    
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse, .authorizedAlways: return "authorized"
        case .restricted, .denied: return "denied"
        default: return "unknown"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.last
        let geocoder = GMSGeocoder()

        let loc_coords = CLLocationCoordinate2D(latitude: Double(lastKnownLocation?.coordinate.latitude ?? 0.0), longitude: Double(lastKnownLocation?.coordinate.longitude ?? 0.0))

        geocoder.reverseGeocodeCoordinate(loc_coords) { response, error in
          //
        if error != nil {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    } else {
                        if let places = response?.results() {
                            if let place = places.first {


                                if let _ = place.lines {
                                    //print("GEOCODE: Formatted Address: \(lines)")
                                }

                            } else {
                                print("GEOCODE: nil first in places")
                            }
                        } else {
                            print("GEOCODE: nil in places")
                        }
                    }
        }
    }
}
