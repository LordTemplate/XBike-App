//
//  MyProgressViewModel.swift
//  XBike
//
//  Created by Ivan Alejandro Hernandez Sanchez on 28/03/25.
//


import SwiftUI

class MyProgressViewModel: ObservableObject {
    @Published var rides: [Ride] = UserDefaultsManager.loadRides()
    
    func updateRides() {
        rides = UserDefaultsManager.loadRides()
    }
    
    func formatDuration(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d : %02d : %02d", hours, minutes, remainingSeconds)
    }
}
