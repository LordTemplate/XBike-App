//
//  UserDefaultsManager.swift
//  XBike
//
//  Created by Ivan Alejandro Hernandez Sanchez on 28/03/25.
//


import Foundation

class UserDefaultsManager {
    static let key = "savedRides"
    
    static func saveRides(_ rides: [Ride]) {
        if let encoded = try? JSONEncoder().encode(rides) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    static func loadRides() -> [Ride] {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Ride].self, from: data) {
            return decoded
        }
        return []
    }
}
