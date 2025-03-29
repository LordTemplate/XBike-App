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
        List(viewModel.rides) { ride in
            VStack(alignment: .leading) {
                Text("From: \(ride.startAddress) to \(ride.finishAddress)")
                Text("Duration: \(ride.duration) sec, Distance: \(ride.distance) km")
            }
        }
    }
}

#Preview {
    MyProgressView()
}
