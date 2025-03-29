//
//  MyProgressViewModel.swift
//  XBike
//
//  Created by Ivan Alejandro Hernandez Sanchez on 28/03/25.
//


import SwiftUI

class MyProgressViewModel: ObservableObject {
    @Published var rides: [Ride] = UserDefaultsManager.loadRides()
}
