//
//  CurrentRideView.swift
//  XBike
//
//  Created by Ivan Alejandro Hernandez Sanchez on 28/03/25.
//


import SwiftUI

struct CurrentRideView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var viewModel = CurrentRideViewModel()

    var body: some View {
        ZStack {
            if let _ = locationManager.userLocation {
                GoogleMapsViewWrapper(locationManager: locationManager) { mapView in
                    viewModel.configureMapView(mapView)
                                }
            } else {
                Text("Waiting for location permissions...")
                    .onAppear {
                        locationManager.requestLocationPermissions()
                    }
            }
            
            VStack {
                HStack {
                    Spacer()
                    GenericText(
                        text: "Current Ride",
                        lineLimit: 1,
                        fontSize: 16,
                        color: Color(hex: "#FFFFFF")
                    )
                    Spacer()
                    Button(action: {
                        viewModel.reset()
                        viewModel.showTrackingInfo.toggle()
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.orange)
                            .clipShape(Circle())
                    }
                }
                .padding()
                .background(Color.orange)
                
                Spacer()
                
                if viewModel.showTrackingInfo && !viewModel.istrackingStopped {
                    VStack(spacing: 10) {
                        GenericText(
                            text: "\(viewModel.formatDuration(seconds: viewModel.elapsedTime))",
                            lineLimit: 1,
                            multilineTextAlignment: .center
                        )
                        .padding(.top, 8)

                        HStack {
                            GenericButton(text: "START", type: .action) {
                                viewModel.startAction()
                            }
                            
                            Rectangle()
                                .frame(width: 1, height: 24)
                                .foregroundColor(Color(hex: "#FF8E25"))
                            
                            GenericButton(text: "STOP") {
                                viewModel.stopAction()
                            }
                        }
                        .padding(.bottom, 8)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)

                } else if viewModel.showTrackingInfo && viewModel.istrackingStopped {
                    VStack(spacing: 10) {
                        GenericText(
                            text: "Your time was",
                            lineLimit: 1,
                            multilineTextAlignment: .center
                        )
                        .padding(.top, 8)
                        
                        GenericText(
                            text: "\(viewModel.formatDuration(seconds: viewModel.elapsedTime))",
                            lineLimit: 1,
                            multilineTextAlignment: .center
                        )
                        .padding(.top, 8)
                        
                        
                        GenericText(
                            text: "Distance",
                            lineLimit: 1,
                            multilineTextAlignment: .center
                        )
                        .padding(.top, 8)
                        
                        if let startLocation = viewModel.startLocation, let endLocation = viewModel.endLocation {
                            GenericText(
                                text: "\(String(format: "%.1f", viewModel.calculateDistance(from: startLocation, to: endLocation))) km",
                                fontSize: 25,
                                allWidth: false
                            )
                        }
                        

                        HStack {
                            GenericButton(text: "STORE", type: .action) {
                                viewModel.saveRide()
                            }
                            
                            Rectangle()
                                .frame(width: 1, height: 24)
                                .foregroundColor(Color(hex: "#FF8E25"))
                            
                            GenericButton(text: "DELETE") {
                                viewModel.reset()
                            }
                        }
                        .padding(.bottom, 8)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 100)

                } else if viewModel.showConfirmation{
                    VStack(spacing: 10) {
                        GenericText(
                            text: "Your progress has been correctly stored!",
                            lineLimit: 2,
                            multilineTextAlignment: .center
                        )
                        .padding(.vertical, 30)
                        
                        HStack {
                            GenericButton(text: "Ok") {
                                viewModel.reset()
                                viewModel.showTrackingInfo.toggle()
                            }
                        }
                        .padding(.bottom, 8)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 100)
                } else {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                print("Navigate action triggered")
                            }) {
                                Image(systemName: "location.fill")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.orange)
                                    .clipShape(Circle())
                                    .shadow(radius: 3)
                            }
                            .padding(.trailing, 16)
                            .padding(.bottom, 86)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CurrentRideView()
}
