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
        for familyName in UIFont.familyNames {
            print("Font Family: \(familyName)")
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                print("Font Name: \(fontName)")
            }
        }
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, GMSMapViewDelegate {
        var parent: GoogleMapsView
        
        init(_ parent: GoogleMapsView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: GMSMapView, didTapMyLocationButton forLocationButton: UIButton) -> Bool {
            if let myLocation = mapView.myLocation {
                let camera = GMSCameraPosition.camera(withTarget: myLocation.coordinate, zoom: 15.0)
                mapView.animate(to: camera)
            }
            return true
        }
    }
}
