//
//  ColorExt.swift
//  TestSwiftUI
//
//  Created by Neil on 5/6/25.
//

import Foundation
import SwiftUI

extension Color {
    public init(red: Int, green: Int, blue: Int, opacity: Double = 1.0) {
        let redValue = Double(red) / 255.0
        let greenValue = Double(green) / 255.0
        let blueValue = Double(blue) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue, opacity: opacity)
    }
    public static let gradientPink = Color(red: 210, green: 153, blue: 194)
    public static let gradientYellow = Color(red: 254, green: 249, blue: 215)
}

