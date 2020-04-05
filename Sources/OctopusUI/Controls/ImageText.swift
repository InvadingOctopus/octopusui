//
//  ImageText.swift
//  OctopusUI
//  https://github.com/InvadingOctopus/octopusui
//
//  Created by ShinryakuTako@invadingoctopus.io on 2019/9/8.
//  Copyright © 2019 Invading Octopus. Licensed under Apache License v2.0 (see LICENSE.txt)
//

//  TODO: Improve image and text alignments

//  🖥 MAC: For macOS, simply copy a symbol from the SF Symbols app and use it as any other emoji inside a string.

import SwiftUI

#if canImport(UIKit)

/// Displays an `HStack` with an `Image` for the specified SF Symbol and `Text`.
public struct ImageText: View {
    
    public var systemName:      String
    public var imageScale:      Image.Scale = .large
    public var label:           String
    public var font:            Font? = nil

    public init(systemName:     String,
                  imageScale:   Image.Scale = .large,
                  label:        String,
                  font:         Font? = nil)
    {
        self.systemName = systemName
        self.imageScale = imageScale
        self.label      = label
        self.font       = font
    }
    
    public var body: some View {
        HStack(alignment: .center) {
            
            Image(systemName: systemName)
                .imageScale(imageScale)
                .alignmentGuide(.imageText) { dimensions in
                    dimensions[.trailing]
            }
            
            Text(label)
                .font(font)
                .alignmentGuide(.imageText) { dimensions in
                    dimensions[.leading]
            }
        }
    }
}

public extension HorizontalAlignment {

    enum ImageText: AlignmentID {
        public static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.center]
        }
    }
    
    static let imageText = HorizontalAlignment(ImageText.self)
}

struct ImageText_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .imageText) {
            ImageText(systemName: "textbox", label: "Preview")
            ImageText(systemName: "2.circle.fill", label: "Second Label")
            ImageText(systemName: "textformat.123", label: "Third Label")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

#endif
