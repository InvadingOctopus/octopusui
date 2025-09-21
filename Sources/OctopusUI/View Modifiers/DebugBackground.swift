//
//  DebugBackground.swift
//  OctopusUI
//  https://github.com/InvadingOctopus/octopusui
//
//  Created by ShinryakuTako@invadingoctopus.io on 2025/08/26.
//  Copyright © 2025 Invading Octopus. Licensed under Apache License v2.0 (see LICENSE.txt)

import SwiftUI


/// A View modifier that adds a colored background only in DEBUG builds to aid layout debugging.
public struct DebugBackground: ViewModifier {
    public var color: Color = Color.randomExcludingBlackWhite
    
    public func body(content: Content) -> some View {
        #if DEBUG
        content.background(color.opacity(0.5))
        #else
        content
        #endif
    }
}


public extension View {
    func debugBackground(_ color: Color = Color.randomExcludingBlackWhite) -> some View {
        modifier(DebugBackground(color: color))
    }
}
