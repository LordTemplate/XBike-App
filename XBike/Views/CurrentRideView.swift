//
//  CurrentRideView.swift
//  XBike
//
//  Created by Ivan Alejandro Hernandez Sanchez on 28/03/25.
//


import SwiftUI
import GoogleMaps

struct CurrentRideView: View {
    @StateObject private var viewModel = CurrentRideViewModel()
    @State private var mapView = GMSMapView(frame: .zero)
    
    var body: some View {
        ZStack {
            GoogleMapsView(mapView: $mapView)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: { viewModel.showTrackingInfo.toggle() }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .padding()
                    }
                }
                .padding()
                
                Spacer()
                
                if viewModel.showTrackingInfo {
                    VStack(spacing: 10) {
                        Text("Elapsed Time: \(viewModel.elapsedTime) sec")
                        HStack {
                            Button("Start") {
                                viewModel.toggleTracking()
                            }
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            
                            Button("Stop") {
                                viewModel.toggleTracking()
                            }
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
                
                HStack {
                    Button("Current Ride") { }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                    Button("Progress") { }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}

#Preview {
    CurrentRideView()
}
