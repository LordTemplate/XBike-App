//
//  MainTabView.swift
//  XBike
//
//  Created by Ivan Alejandro Hernandez Sanchez on 28/03/25.
//


import SwiftUI

struct MainTabView: View {
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
    }
}
