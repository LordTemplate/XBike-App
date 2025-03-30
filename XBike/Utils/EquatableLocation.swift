//
//  EquatableLocation.swift
//  XBike
//
//  Created by Ivan Alejandro Hernandez Sanchez on 28/03/25.
//


import CoreLocation

struct EquatableLocation: Equatable {
    let latitude: Double
    let longitude: Double

    init(from coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }

    static func ==(lhs: EquatableLocation, rhs: EquatableLocation) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
