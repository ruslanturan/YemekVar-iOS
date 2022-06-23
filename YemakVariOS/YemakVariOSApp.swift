//
//  YemakVariOSApp.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 19.04.22.
//

import SwiftUI
import GoogleMaps
 
 let APIKey = "AIzaSyAktdnU5whsW51QkIro-ZSN3JCnihvfYis"
@main
struct YemakVariOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
