//
//  Color.swift
//  Fairway
//
//  Created by Leonardo David Arias Ruiz on 04/03/23.
//

import SwiftUI

extension Color {
    init(hex: String) {
        var colorString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if colorString.hasPrefix("#") {
            colorString.remove(at: colorString.startIndex)
        }

        if colorString.count != 6 {
            self.init(.gray)
            return
        }

        var rgbValue: UInt64 = 0
        Scanner(string: colorString).scanHexInt64(&rgbValue)

        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

extension Color {
    var hex: String {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let hexString = String(format: "#%02x%02x%02x", Int(red*255), Int(green*255), Int(blue*255))
        return hexString
    }
}
