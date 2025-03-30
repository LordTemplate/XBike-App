//
//  XBikeApp.swift
//  XBike
//
//  Created by Ivan Alejandro Hernandez Sanchez on 28/03/25.
//

import SwiftUI
import GoogleMaps

@main
struct XBikeApp: App {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    init() {
        GMSServices.provideAPIKey("AIzaSyAdypWXKWvq0LIOCsZj7e_tNXz8skjbMq0")
    }
    
    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                MainTabView()
            } else {
                OnboardingView()
            }
        }
    }
}
