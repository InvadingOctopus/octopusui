//
//  Color+OctopusUI.swift
//  OctopusUI
//  https://github.com/InvadingOctopus/octopusui
//
//  Created by ShinryakuTako@invadingoctopus.io on 2019/10/23.
//  Copyright © 2020 Invading Octopus. Licensed under Apache License v2.0 (see LICENSE.txt)
//

import SwiftUI

public extension SwiftUI.Color {
    
    // MARK: All Members
    
    /// An array of all the predefined colors, **excluding** `clear`, `primary`, `secondary` and `accentColor`.
    ///
    /// The list contains all the predefine colors on iOS 17 and macOS 14.
    static let allColors: [Self] = [
        black,  blue,   brown,  cyan,
        gray,   green,  indigo, mint,
        orange, pink,   purple, red,
        teal,   yellow, white
    ]
    
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
        Self.allColors.randomElement()!
    }
    
    /// Returns a random `Color` from the list of preset colors, **excluding** `black` and `white`.
    static var randomExcludingBlackWhite: Color {
        // NOTE: This must be a COMPUTED property! Assigning a value makes this a static variable, which will always be the first color it gets. :)
        Self.allColors.filter {
            $0 != white && $0 != black
        }.randomElement()!
    }
}
