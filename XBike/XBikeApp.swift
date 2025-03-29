//
//  XBikeApp.swift
//  XBike
//
//  Created by Ivan Alejandro Hernandez Sanchez on 28/03/25.
//
/*
import SwiftUI

@main
struct XBikeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
*/
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

struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var currentPage = 0
    
    var body: some View {
        TabView(selection: $currentPage) {
            OnboardingPageView(image: "simple", text: "Extremely simple to use.")
                .tag(0)
            OnboardingPageView(image: "track", text: "Track your time and distance.")
                .tag(1)
            OnboardingPageView(image: "progress", text: "See your progress and challenge yourself!")
                .tag(2)
        }
        .tabViewStyle(PageTabViewStyle())
        .overlay(
            Button("Get Started") {
                hasSeenOnboarding = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(), alignment: .bottom
        )
    }
}

struct OnboardingPageView: View {
    let image: String
    let text: String
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            Text(text)
                .font(.title)
                .padding()
        }
    }
}
