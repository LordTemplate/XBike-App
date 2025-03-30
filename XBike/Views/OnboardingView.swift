//
//  OnboardingView.swift
//  XBike
//
//  Created by Ivan Alejandro Hernandez Sanchez on 29/03/25.
//


import SwiftUI

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
        .background(Color(hex: "#FF8E25"))
    }
}
