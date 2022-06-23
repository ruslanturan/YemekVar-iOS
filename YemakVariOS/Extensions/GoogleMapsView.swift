//
//  GoogleMapsView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 02.05.22.
//

import SwiftUI
import GoogleMaps

struct GoogleMapsView: UIViewRepresentable{
    @State var userLat = 0.0
    @State var userLon = 0.0
    @State var courierLat = 0.0
    @State var courierLon = 0.0
    func makeUIView(context: Context) -> GMSMapView {
        
        let camera = GMSCameraPosition.london
                 
        let mapView = GMSMapView(frame: CGRect.zero, camera: camera)
        let url = URL(string: "https://yemekvar.az/api/user/orderTrack")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let body: [String: String] = ["orderid": UserDefaults.standard.string(forKey: "OrderID")!]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do{
            let str = String(decoding: data, as: UTF8.self)
                if !(str.lowercased().contains("error")){
                    let json = try ((JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? NSDictionary)!)

                    userLat = Double(json["Latitude"] as! String)!
                    userLon = Double(json["Longitude"] as! String)!
                    
                    courierLat = Double(json["courierLat"] as! String)!
                    courierLon = Double(json["courierLon"] as! String)!

                    let marker: GMSMarker = GMSMarker()
                    marker.icon = UIImage(named: "Icon-courier") // Marker icon
                    marker.setIconSize(scaledToSize: .init(width: 40, height: 40))
                    marker.appearAnimation = .pop
                    let loc_coords = CLLocationCoordinate2D(latitude: courierLat, longitude: courierLon)
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
                    let loc_coords2 = CLLocationCoordinate2D(latitude: userLat, longitude: userLon)
                    marker3.position = loc_coords2 // CLLocationCoordinate2D
                    DispatchQueue.main.async { // Setting marker on mapview in main thread.
                        marker3.map = mapView // Setting marker on Mapview
                    }
                    let bounds = GMSCoordinateBounds(coordinate: loc_coords, coordinate: loc_coords2)
                    let cam: GMSCameraUpdate = GMSCameraUpdate.fit(bounds, withPadding: 50)

                    //  let cameraWithPadding: GMSCameraUpdate = GMSCameraUpdate.fit(bounds, withPadding: 100.0) (will put inset the bounding box from the view's edge)

                    mapView.animate(with: cam)
            //        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)

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

extension GMSCameraPosition  {
    static var london = GMSCameraPosition.camera(withLatitude: 40.3987809, longitude: 49.7148753, zoom: 14)
    
}
extension GMSMarker {
    func setIconSize(scaledToSize newSize: CGSize) {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        icon?.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        icon = newImage
    }
}
