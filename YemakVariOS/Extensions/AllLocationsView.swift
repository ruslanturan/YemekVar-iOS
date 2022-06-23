//
//  AllLocationsView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 16.05.22.
//

import SwiftUI
import GoogleMaps

struct AllLocationsView: UIViewRepresentable {
    @ObservedObject var location = LocationManager()

    var lat: String {
        return "\(location.lastKnownLocation?.coordinate.latitude ?? 0.0)"
    }

    var lon: String {
        return "\(location.lastKnownLocation?.coordinate.longitude ?? 0.0)"
    }
    init() {
        self.location.startUpdating()
    }
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.london
        let mapView = GMSMapView(frame: CGRect.zero, camera: camera)
        
        var restaurants: [NSDictionary] = []
        let url = URL(string: "https://yemekvar.az/api/reservation/getlocations")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do{
            let str = String(decoding: data, as: UTF8.self)
                if !(str.lowercased().contains("error")){
                    restaurants = try (JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? [NSDictionary])!
                    
                    for restaurant in restaurants{
                        let marker: GMSMarker = GMSMarker()
                        marker.icon = UIImage(named: "Icon-location-restaurant")
                        marker.setIconSize(scaledToSize: .init(width: 41, height: 54))
                        marker.appearAnimation = .pop
                        let loc_coords = CLLocationCoordinate2D(latitude: Double(restaurant["Latitude"] as! String) ?? 40.408659, longitude: Double(restaurant["Longitude"] as! String) ?? 49.864891)
                        marker.position = loc_coords
                        DispatchQueue.main.async {
                           marker.map = mapView
                            
                        }
                        let marker3: GMSMarker = GMSMarker() // Allocating Marker
                        marker3.title = "Title" // Setting title
                        marker3.snippet = "Sub title" // Setting sub title
                        marker3.icon = UIImage(named: "Icon-location") // Marker icon
                        marker3.setIconSize(scaledToSize: .init(width: 41, height: 44))
                        marker3.appearAnimation = .pop // Appearing animation. default
                        let loc_coords2 = CLLocationCoordinate2D(latitude: Double(lat) ?? 40.408659, longitude: Double(lon) ?? 49.864891)
                        marker3.position = loc_coords2 // CLLocationCoordinate2D
                        DispatchQueue.main.async { // Setting marker on mapview in main thread.
                            marker3.map = mapView // Setting marker on Mapview
                        }
                        mapView.animate(toLocation: loc_coords2)
                    }

                }
                else{

                }
            }
            catch{
                print(error)
            }
        }.resume()
        
        
        
       
        


        
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        
    }
}

