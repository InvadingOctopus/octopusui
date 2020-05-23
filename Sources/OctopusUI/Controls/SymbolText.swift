//
//  SymbolText.swift
//  OctopusUI
//  https://github.com/InvadingOctopus/octopusui
//
//  Created by ShinryakuTako@invadingoctopus.io on 2019/9/8.
//  Copyright © 2020 Invading Octopus. Licensed under Apache License v2.0 (see LICENSE.txt)
//

import SwiftUI

/// Displays an `HStack` with the specified SF Symbol and a `Text` label.
public struct SymbolText: View {

    // TODO: Improve image and text alignments
    // CHECK: Enforce single characters on macOS?
    
    /// The string containing the symbol(S) pasted from the SF Symbols app, like emoji.
    let macOSText:      String
    
    /// The "system name" of the symbol.
    let iOSSystemName:  String
    
    /// The text to display next to the symbol.
    let label:          String

    #if os(macOS) // MARK: - macOS
    
    /// Creates an `Image` view next to a `Text` view on iOS/iPadOS/tvOS, or two `Text` views on macOS containing a symbol and a label.
    /// - Parameters:
    ///   - macOS: The string containing the symbol(s). Use Apple's SF Symbols catalog app to copy and paste symbols like any other emoji (using `⌘C` and `⌘V`).
    ///   - iOS: The "system name" of the symbol (like `"square.and.arrow.up"` for the Share icon). Use Apple's SF Symbols catalog app to copy symbol names (using `⇧⌘C`).
    public init(macOS:  String,
                iOS:    String,
                label:  String)
    {
        self.iOSSystemName  = iOS
        self.macOSText      = macOS
        self.label          = label
    }
    
    public var body: some View {
        HStack(alignment: .center) {
            
            Symbol(macOS: macOSText, iOS: iOSSystemName)
                .alignmentGuide(.imageText) { dimensions in
                    dimensions[.trailing]
            }
            
            Text(label)
                .alignmentGuide(.imageText) { dimensions in
                    dimensions[.leading]
            }
        }
    }
    
    #elseif canImport(UIKit) // MARK: - iOS/iPadOS/tvOS
    
    let imageScale: Image.Scale
    
    /// Creates an `Image` view next to a `Text` view on iOS/iPadOS/tvOS, or two `Text` views on macOS containing a symbol and a label.
    /// - Parameters:
    ///   - macOS: The string containing the symbol(s). Use Apple's SF Symbols catalog app to copy and paste symbols like any other emoji (using `⌘C` and `⌘V`).
    ///   - iOS: The "system name" of the symbol (like `"square.and.arrow.up"` for the Share icon). Use Apple's SF Symbols catalog app to copy symbol names (using `⇧⌘C`).
    ///   - scale: The scale of the image on iOS/iPadOS/tvOS. Default: `.medium`
    public init(macOS:  String,
                iOS:    String,
                scale:  Image.Scale = .medium,
                label:  String)
    {
        self.iOSSystemName  = iOS
        self.macOSText      = macOS
        self.imageScale     = scale
        self.label          = label
    }
    
    public var body: some View {
        HStack(alignment: .center) {
            
            Symbol(macOS: macOSText, iOS: iOSSystemName, scale: imageScale)
                .alignmentGuide(.symbolText) { dimensions in
                    dimensions[.trailing]
            }
            
            Text(label)
                .alignmentGuide(.symbolText) { dimensions in
                    dimensions[.leading]
            }
        }
    }
    
    #endif
    
}

public extension HorizontalAlignment {

    private enum SymbolText: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.center]
        }
    }
    
    static let symbolText = HorizontalAlignment(SymbolText.self)
}

struct ImageText_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .symbolText) {
            SymbolText(macOS: "􀅶", iOS: "textbox", label: "Preview")
            SymbolText(macOS: "􀀽", iOS: "2.circle.fill", label: "Second Label")
            SymbolText(macOS: "􀅱", iOS: "textformat.123", label: "Third Label")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
