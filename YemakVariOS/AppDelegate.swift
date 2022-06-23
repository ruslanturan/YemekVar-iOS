//
//  AppDelegate.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 02.05.22.
//

import SwiftUI
import GoogleMaps
import GooglePlacesAPI
class AppDelegate: NSObject, UIApplicationDelegate    {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GMSServices.provideAPIKey("AIzaSyAktdnU5whsW51QkIro-ZSN3JCnihvfYis")

        return true
    }
 }
