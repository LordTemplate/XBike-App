//
//  LocationManager.swift
//  XBike
//
//  Created by Ivan Alejandro Hernandez Sanchez on 28/03/25.
//


import CoreLocation
import SwiftUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()

    @Published var userLocation: EquatableLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        requestLocationPermissions()
    }

    func requestLocationPermissions() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            DispatchQueue.main.async {
                self.userLocation = EquatableLocation(from: location.coordinate)
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        } else {
            print("Permiso denegado o restringido")
        }
    }
}
