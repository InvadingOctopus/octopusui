//
//  Color+OctopusUI.swift
//  OctopusUI
//  https://github.com/InvadingOctopus/octopusui
//
//  Created by ShinryakuTako@invadingoctopus.io on 2019/10/23.
//  Copyright © 2025 Invading Octopus. Licensed under Apache License v2.0 (see LICENSE.txt)
//

import SwiftUI

public extension SwiftUI.Color {

    // MARK: All Members

    /// An array of all the predefined colors, **excluding** `clear`, `primary`, `secondary` and `accentColor`.
    ///
    /// The list contains all the predefined colors on iOS and macOS. Some colors may be context-dependent, i.e. different in dark mode vs. light mode etc.
    static let presets: [Self] = [
        black,  white,  gray,
        red,    orange, yellow,
        green,  mint,   teal,
        cyan,   blue,   indigo,
        purple, pink,   brown,
    ]


    enum Name: String, CaseIterable {

        case black, white,  gray,
             red,   orange, yellow,
             green, mint,   teal,
             cyan,  blue,   indigo,
             purple,pink,   brown


        public var color: Color {
            switch self {
            case .black:  return .black
            case .white:  return .white
            case .gray:   return .gray
            case .red:    return .red
            case .orange: return .orange
            case .yellow: return .yellow
            case .green:  return .green
            case .mint:   return .mint
            case .teal:   return .teal
            case .cyan:   return .cyan
            case .blue:   return .blue
            case .indigo: return .indigo
            case .purple: return .purple
            case .pink:   return .pink
            case .brown:  return .brown
            }
        }


        public static var allCasesSorted: [Self] {
            allCases.sorted { $0.rawValue.lexicographicallyPrecedes($1.rawValue) }
        }


        public init?(string: String) {
            let lowercased = string.lowercased()
            if let match = Self.allCases.first(where: { $0.rawValue.lowercased() == lowercased }) {
                self = match
            } else {
                return nil
            }
        }
    }


    // MARK: Sinclair Spectrum
    // Colors that are always at full saturation, not dependent on the system definitions for common colors.

    /// Red: `0`, Green: `0`, Blue: `1.0`
    static let blueSaturated    = Self.init(red: 0.0,   green: 0.0, blue: 1.0)

    /// Red: `0`, Green: `1.0`, Blue: `1.0`
    static let cyanSaturated    = Self.init(red: 0.0,   green: 1.0, blue: 1.0)

    /// Red: `0`, Green: `1.0`, Blue: `0`
    static let greenSaturated   = Self.init(red: 0.0,   green: 1.0, blue: 0.0)

    /// Red: `1.0`, Green: `0`, Blue: `1.0`
    static let magentaSaturated = Self.init(red: 1.0,   green: 0.0, blue: 1.0)

    /// Red: `1.0`, Green: `0`, Blue: `0`
    static let redSaturated     = Self.init(red: 1.0,   green: 0.0, blue: 0.0)

    /// Red: `1.0`, Green: `1.0`, Blue: `0`
    static let yellowSaturated  = Self.init(red: 1.0,   green: 1.0, blue: 0.0)

    // MARK: Random Colors

    /// Returns a random `Color` from the list of predefined colors (as of 2019/10/23), **excluding** `clear`, `primary`, `secondary` and `accentColor`.
    static var random: Color {
        // NOTE: This must be a COMPUTED property! Assigning a value makes this a static variable, which will always be the first color it gets. :)
        Self.presets.randomElement()!
    }

    /// Returns a random `Color` from the list of preset colors, **excluding** `black` and `white`.
    static var randomExcludingBlackWhite: Color {
        // NOTE: This must be a COMPUTED property! Assigning a value makes this a static variable, which will always be the first color it gets. :)
        Self.presets.filter {
            $0 != white && $0 != black
        }.randomElement()!
    }

    // MARK: - Constructors

    /// Creates a `Color` from a hexadecimal string representing RGB values (e.g. "#RRGGBB", "RRGGBB", "#RGB", or "RGB").
    /// If the input is invalid, `.clear` is returned.
    init(hex: String) {
        var hexString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if  hexString.hasPrefix("#") {
            hexString.removeFirst()  }

        var rgbValue: UInt64 = 0
        if  hexString.count == 6, Scanner(string: hexString).scanHexInt64(&rgbValue) {
            let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
            let g = Double((rgbValue & 0x00FF00) >> 8)  / 255.0
            let b = Double( rgbValue & 0x0000FF)        / 255.0
            self.init(red: r, green: g, blue: b)
        } else if hexString.count == 3, Scanner(string: hexString).scanHexInt64(&rgbValue) {
            // Expand short form (RGB -> RRGGBB)
            let r = Double((rgbValue & 0xF00) >> 8) / 15.0
            let g = Double((rgbValue & 0x0F0) >> 4) / 15.0
            let b = Double( rgbValue & 0x00F)       / 15.0
            self.init(red: r, green: g, blue: b)
        } else {
            self = .clear }
    }

    // MARK: - Modifiers


}

