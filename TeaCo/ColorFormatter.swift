//
//  ColorFormatter.swift
//  TeaCo
//
//  Created by Rachel Rafik on 1/25/24.
//

import Foundation
import SwiftUI

func hexStringToColor(_ hex: String) -> Color {
    var hexFormatted = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

    guard hexFormatted.count == 6 else {
        return Color.clear // Return a default color if the hex string is not 6 characters
    }

    var rgbValue: UInt64 = 0
    Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

    let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
    let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
    let blue = Double(rgbValue & 0x0000FF) / 255.0

    return Color(.sRGB, red: red, green: green, blue: blue, opacity: 1.0)
}
