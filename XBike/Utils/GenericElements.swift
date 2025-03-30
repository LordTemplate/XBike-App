//
//  GenericButton.swift
//  XBike
//
//  Created by Ivan Alejandro Hernandez Sanchez on 29/03/25.
//


import SwiftUI

struct GenericButton: View {
    var text: String
    var type: ButtonType = .default
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.custom("Abel-Regular", size: 15))
                .fontWeight(.regular)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.clear)
                .foregroundColor(type.foregroundColor)
                .multilineTextAlignment(.center)
                .frame(height: 30)

        }
    }
}

enum ButtonType {
    case action
    case cancel
    case `default`

    var foregroundColor: Color {
        switch self {
        case .action:
            return Color(hex: "#FF8E25")
        case .cancel, .default:
            return Color(hex: "#BDBDBD")
        }
    }
}

struct GenericText: View {
    var text: String
    var lineLimit: Int = 0
    var multilineTextAlignment: TextAlignment = .leading
    var fontSize: CGFloat = 30
    var color: Color = Color(hex: "##000000")
    var allWidth: Bool = true
    
    var body: some View {
        if allWidth {
            Text(text)
                .font(.custom("Abel-Regular", size: fontSize))
                .fontWeight(.regular)
                .lineLimit(lineLimit)
                .multilineTextAlignment(multilineTextAlignment)
                .kerning(0)
                .frame(maxWidth: .infinity)
                .foregroundColor(color)
        } else {
            Text(text)
                .font(.custom("Abel-Regular", size: fontSize))
                .fontWeight(.regular)
                .lineLimit(lineLimit)
                .multilineTextAlignment(multilineTextAlignment)
                .kerning(0)
                .foregroundColor(color)
        }
    }
}
