//
//  MainTabView.swift
//  XBike
//
//  Created by Ivan Alejandro Hernandez Sanchez on 28/03/25.
//


import SwiftUI

struct MainTabView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor(hex: "#FAF8F8")
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        UITabBar.appearance().tintColor = UIColor.orange
        
        let fontAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Abel-Regular", size: 10) ?? UIFont.systemFont(ofSize: 10)
        ]
        
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal) // No seleccionado
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .selected) // Seleccionado
    }

    var body: some View {
        TabView {
            CurrentRideView()
                .tabItem {
                    Label("Current Ride", systemImage: "bicycle")
                }
            MyProgressView()
                .tabItem {
                    Label("My Progress", systemImage: "chart.bar")
                }
        }
        .accentColor(.orange)
    }
}
