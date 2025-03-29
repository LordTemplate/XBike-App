//
//  GoogleMapsView.swift
//  XBike
//
//  Created by Ivan Alejandro Hernandez Sanchez on 28/03/25.
//


import SwiftUI
import GoogleMaps

struct GoogleMapsView: UIViewRepresentable {
    @Binding var mapView: GMSMapView
    
    func makeUIView(context: Context) -> GMSMapView {
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {}
}

#Preview {
    //GoogleMapsView(mapView: <#Binding<GMSMapView>#>)
}
