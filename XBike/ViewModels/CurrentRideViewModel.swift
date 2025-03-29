//
//  CurrentRideViewModel.swift
//  XBike
//
//  Created by Ivan Alejandro Hernandez Sanchez on 28/03/25.
//


import SwiftUI
import GoogleMaps

class CurrentRideViewModel: ObservableObject {
    @Published var isTracking = false
    @Published var elapsedTime = 0
    @Published var rides: [Ride] = UserDefaultsManager.loadRides()
    @Published var showTrackingInfo = false
    
    private var timer: Timer?
    
    func toggleTracking() {
        isTracking.toggle()
        isTracking ? startTimer() : stopTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            DispatchQueue.main.async {
                self.elapsedTime += 1
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        saveRide()
    }
    
    private func saveRide() {
        let newRide = Ride(startAddress: "Point A", finishAddress: "Point B", duration: elapsedTime, distance: 10.0)
        rides.append(newRide)
        UserDefaultsManager.saveRides(rides)
    }
}
