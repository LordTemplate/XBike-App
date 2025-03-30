//
//  CurrentRideViewModel.swift
//  XBike
//
//  Created by Ivan Alejandro Hernandez Sanchez on 28/03/25.
//


import SwiftUI
import GoogleMaps

class CurrentRideViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var isTracking = false
    @Published var elapsedTime = 0
    @Published var rides: [Ride] = UserDefaultsManager.loadRides()
    @Published var showTrackingInfo = false
    @Published var istrackingStopped = false
    @Published var showConfirmation = false
    

    private var timer: Timer?
    private var locationManager = CLLocationManager()
    private var mapView: GMSMapView?
    private var polylinePath = GMSMutablePath()

    @Published var startLocation: CLLocationCoordinate2D?
    @Published var endLocation: CLLocationCoordinate2D?
    
    func reset() {
        stopTracking()
        isTracking = false
        elapsedTime = 0
        istrackingStopped = false
        showConfirmation = false
        //showTrackingInfo = false
        
        mapView?.clear()
        polylinePath.removeAllCoordinates()
    }

    func configureMapView(_ mapView: GMSMapView) {
        self.mapView = mapView
    }

    func startAction() {
        if !isTracking {
            isTracking.toggle()
            startTracking()
            setupLocationManager()
        }
    }
    func stopAction() {
        if isTracking {
            isTracking.toggle()
            istrackingStopped.toggle()
            stopTracking()
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 3
        locationManager.startUpdatingLocation()
    }
    
    func createCircleMarker(color: UIColor, size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let rect = CGRect(origin: .zero, size: size)
            context.cgContext.setFillColor(color.cgColor)
            context.cgContext.fillEllipse(in: rect)
        }
    }

    private func startTracking() {
        startLocation = locationManager.location?.coordinate
        
        if let startLocation = startLocation {
            mapView?.clear()
            polylinePath.removeAllCoordinates()
            
            let startMarker = GMSMarker()
            startMarker.position = startLocation
            startMarker.icon = createCircleMarker(color: UIColor(hex: "#FF8E25"), size: CGSize(width: 24, height: 24))
            startMarker.map = mapView

            polylinePath.add(startLocation)
        }

        drawPolyline()
        
        startTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            DispatchQueue.main.async {
                self.elapsedTime += 1
            }
        }
    }


    private func stopTracking() {
        timer?.invalidate()
        timer = nil
        endLocation = locationManager.location?.coordinate
        
        if let endLocation = endLocation {
            let endMarker = GMSMarker()
            endMarker.position = endLocation
            endMarker.icon = createCircleMarker(color: UIColor(hex: "#FF8E25"), size: CGSize(width: 24, height: 24))
            endMarker.map = mapView
            
            polylinePath.add(endLocation)
        }

        drawPolyline()
    }

    private func drawPolyline() {
        guard let mapView = mapView else { return }

        let polyline = GMSPolyline(path: polylinePath)
        polyline.strokeColor = UIColor(hex: "#FF8E25")
        polyline.strokeWidth = 3.0
        polyline.map = mapView
    }

    func saveRide() {
        guard let startLocation = startLocation, let endLocation = endLocation else {
            print("Ubicaciones no disponibles")
            return
        }

        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(startLocation) { response, error in
            let startAddress = response?.firstResult()?.lines?.joined(separator: ", ") ?? "Unknown Start"
            
            geocoder.reverseGeocodeCoordinate(endLocation) { response, error in
                let finishAddress = response?.firstResult()?.lines?.joined(separator: ", ") ?? "Unknown Finish"
                
                DispatchQueue.main.async {
                    let newRide = Ride(
                        startAddress: startAddress,
                        finishAddress: finishAddress,
                        duration: self.elapsedTime,
                        distance: self.calculateDistance(from: startLocation, to: endLocation)
                    )
                    self.rides.append(newRide)
                    UserDefaultsManager.saveRides(self.rides)
                    
                    self.reset()
                    self.showTrackingInfo.toggle()
                    self.showConfirmation = true
                }
            }
        }
    }

    func calculateDistance(from start: CLLocationCoordinate2D, to end: CLLocationCoordinate2D) -> Double {
        let startPoint = CLLocation(latitude: start.latitude, longitude: start.longitude)
        let endPoint = CLLocation(latitude: end.latitude, longitude: end.longitude)
        return startPoint.distance(from: endPoint) / 1000.0
    }
    
    func formatDuration(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d : %02d : %02d", hours, minutes, remainingSeconds)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if isTracking {
            guard let location = locations.last else { return }
            
            DispatchQueue.main.async {
                self.polylinePath.add(location.coordinate)
                
                self.drawPolyline()
            }
        }
    }
}
