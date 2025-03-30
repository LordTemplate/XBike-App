//
//  GoogleMapsViewWrapper.swift
//  XBike
//
//  Created by Ivan Alejandro Hernandez Sanchez on 28/03/25.
//


import SwiftUI
import GoogleMaps

struct GoogleMapsViewWrapper: View {
    @ObservedObject var locationManager: LocationManager
    @State private var mapView = GMSMapView()
    var configureMapView: (GMSMapView) -> Void

    var body: some View {
        GoogleMapsView(mapView: $mapView)
            .onChange(of: locationManager.userLocation) { newLocation, _ in
                if let location = newLocation {
                    let camera = GMSCameraPosition.camera(withLatitude: location.latitude,
                                                          longitude: location.longitude,
                                                          zoom: 17.0)
                    mapView.animate(to: camera)
                }
            }
            .onAppear {
                configureMapView(mapView)
            }
    }
}

