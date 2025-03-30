//
//  OnboardingPageView.swift
//  XBike
//
//  Created by Ivan Alejandro Hernandez Sanchez on 29/03/25.
//


import SwiftUI

struct OnboardingPageView: View {
    let image: String
    let text: String
    
    var body: some View {
        VStack(alignment: .center) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            GenericText(
                text: text,
                lineLimit: 3,
                fontSize: 24,
                color: Color(hex: "#FFFFFF")
            )
            .padding()
        }
    }
}
