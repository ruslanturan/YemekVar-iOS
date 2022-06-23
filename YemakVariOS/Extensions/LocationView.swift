//
//  LocationView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 14.05.22.
//

import SwiftUI
import GoogleMaps

struct LocationView: UIViewRepresentable {
    @State private var lat = UserDefaults.standard.string(forKey: "restLat") ?? ""
    @State private var lon = UserDefaults.standard.string(forKey: "restLon") ?? ""



    func makeUIView(context: Context) -> GMSMapView {
        let doubLat = Double(lat) ?? 0
        let doubleLon = Double(lon) ?? 0
        let camera = GMSCameraPosition.london
                 
        let mapView = GMSMapView.map(withFrame: CGRect(x:0, y:0, width:UIScreen.screenWidth, height:UIScreen.screenHeight - 200), camera: camera)
        let marker: GMSMarker = GMSMarker() // Allocating Marker

         marker.title = "Title" // Setting title
         marker.snippet = "Sub title" // Setting sub title
        marker.icon = UIImage(named: "Icon-location-restaurant") // Marker icon
        marker.setIconSize(scaledToSize: .init(width: 41, height: 54))
         marker.appearAnimation = .pop // Appearing animation. default
        if !lat.isEmpty && !lon.isEmpty{
            let loc_coords = CLLocationCoordinate2D(latitude: doubLat, longitude: doubleLon)
             marker.position = loc_coords // CLLocationCoordinate2D
            DispatchQueue.main.async { // Setting marker on mapview in main thread.
               marker.map = mapView // Setting marker on Mapview
            }

            mapView.animate(toLocation: loc_coords)
        }
       

        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        
    }
}

