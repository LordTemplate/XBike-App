//
//  MyProgressView.swift
//  XBike
//
//  Created by Ivan Alejandro Hernandez Sanchez on 28/03/25.
//


import SwiftUI

struct MyProgressView: View {
    @StateObject private var viewModel = MyProgressViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                GenericText(
                    text: "My Progress",
                    lineLimit: 1,
                    fontSize: 16,
                    color: Color(hex: "#FFFFFF")
                )
                Spacer()
            }
            .padding()
            .background(Color.orange)
            
            List(viewModel.rides) { ride in
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        GenericText(
                            text: "\(viewModel.formatDuration(seconds: ride.duration))",
                            lineLimit: 1,
                            multilineTextAlignment: .leading,
                            allWidth: false
                        )
                        
                        HStack {
                            GenericText(
                                text: "A:",
                                fontSize: 10,
                                color: Color(hex: "#7C7C7C"),
                                allWidth: false
                            )
                            GenericText(
                                text: ride.startAddress,
                                fontSize: 10,
                                color: Color(hex: "#7C7C7C"),
                                allWidth: false
                            )
                        }
                        
                        HStack {
                            GenericText(
                                text: "B:",
                                fontSize: 10,
                                color: Color(hex: "#7C7C7C"),
                                allWidth: false
                            )
                            GenericText(
                                text: ride.finishAddress,
                                fontSize: 10,
                                color: Color(hex: "#7C7C7C"),
                                allWidth: false
                            )
                        }
                    }
                    
                    Spacer()
                                        
                    GenericText(
                        text: "\(String(format: "%.1f", ride.distance)) km",
                        fontSize: 25,
                        allWidth: false
                    )
                    
                }
                .padding(.vertical, 5)
            }
            .onAppear {
                viewModel.updateRides()
            }
            .listStyle(PlainListStyle())
        }
        .background(Color.white)
    }
}

