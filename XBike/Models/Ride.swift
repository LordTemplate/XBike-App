//
//  Ride.swift
//  XBike
//
//  Created by Ivan Alejandro Hernandez Sanchez on 28/03/25.
//


import Foundation

struct Ride: Identifiable, Codable {
    var id = UUID()
    let startAddress: String
    let finishAddress: String
    let duration: Int
    let distance: Double
}