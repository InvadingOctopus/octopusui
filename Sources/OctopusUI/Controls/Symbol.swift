//
//  Symbol.swift
//  OctopusUI
//  https://github.com/InvadingOctopus/octopusui
//
//  Created by ShinryakuTako@invadingoctopus.io on 2020/05/23.
//  Copyright © 2020 Invading Octopus. Licensed under Apache License v2.0 (see LICENSE.txt)
//

import SwiftUI

/// Allows usage of *SF Symbols* on iOS and macOS from a single call.
///
/// For some stupid reasons, Apple does not let you use `image(systemName:)` on macOS, but you *can* use the SF Symbols browser/catalog/viewer app to copy symbols and paste them into any text field on macOS, just like any other emoji. However, symbols copied in that manner are not viewable on iOS.
///
/// This view helps you avoid `#if` `#else` conditional compilation blocks and lets you create an SF Symbol text or image view for any OS with a single call.
@available(*, deprecated, message: "Use Image(systemName:) or Text-embedded Image in the latest OS versions.")
public struct Symbol: View {
    
    // CHECK: Enforce single characters on macOS?
    
    // https://developer.apple.com/design/human-interface-guidelines/sf-symbols/overview/
    // https://developer.apple.com/design/downloads/SF-Symbols.dmg
    
    /// The string containing the symbol pasted from the SF Symbols app, like emoji.
    let macOSText:      String
    
    /// The "system name" of the symbol.
    let iOSSystemName:  String
    
    #if os(macOS) // MARK: - macOS
    
    /// Creates an `Image` view on iOS/iPadOS/tvOS, or a `Text` view on macOS.
    /// - Parameters:
    ///   - macOS: The string containing the symbol(s). Use Apple's SF Symbols catalog app to copy and paste symbols like any other emoji (using `⌘C` and `⌘V`).
    ///   - iOS: The "system name" of the symbol (like `"square.and.arrow.up"` for the Share icon). Use Apple's SF Symbols catalog app to copy symbol names (using `⇧⌘C`).
    public init(macOS:  String,
                iOS:    String)
    {
        self.iOSSystemName  = iOS
        self.macOSText      = macOS
    }
    
    public var body: some View {
        Text(String(macOSText))
    }
    
    #elseif canImport(UIKit) // MARK: - iOS/iPadOS/tvOS
    
    let imageScale: Image.Scale
    
    /// Creates an `Image` view on iOS/iPadOS/tvOS, or a `Text` view on macOS.
    /// - Parameters:
    ///   - macOS: The string containing the symbol(s). Use Apple's SF Symbols catalog app to copy and paste symbols like any other emoji (using `⌘C` and `⌘V`).
    ///   - iOS: The "system name" of the symbol (like `"square.and.arrow.up"` for the Share icon). Use Apple's SF Symbols catalog app to copy symbol names (using `⇧⌘C`).
    ///   - scale: The scale of the image on iOS/iPadOS/tvOS. Default: `.medium`
    public init(macOS:  String,
                iOS:    String,
                scale:  Image.Scale = .medium)
    {
        self.iOSSystemName  = iOS
        self.macOSText      = macOS
        self.imageScale     = scale
    }
    
    public var body: some View {
        Image(systemName: iOSSystemName)
            .imageScale(imageScale)
    }
    
    #endif
}

