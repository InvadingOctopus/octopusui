//
//  ButtonStyles.swift
//  OctopusUI
//  https://github.com/InvadingOctopus/octopusui
//
//  Created by ShinryakuTako@invadingoctopus.io on 2019/11/3.
//  Copyright © 2020 Invading Octopus. Licensed under Apache License v2.0 (see LICENSE.txt)
//

import SwiftUI

public struct FatButtonStyle: ButtonStyle {
    
    public var color:       Color
    public var opacity:     Double
    public var padding:     CGFloat?
    
    public init(color:      Color       = .accentColor,
                opacity:    Double      = 0.85,
                padding:    CGFloat?    = nil)
    {
        self.color          = color
        self.opacity        = opacity
        self.padding        = padding
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.all, self.padding)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(color)
                    .opacity(opacity)
                    .shadow(color: .black,
                            radius: configuration.isPressed ? 5 : 10,
                            x: 0,
                            y: configuration.isPressed  ? -2  : -5)
                    .brightness(configuration.isPressed ? 0.2 : 0)
                    .animation(.easeOut(duration: 0.1)))
    }
}

/// Preview in live mode to test interactivity and animations.
struct FatButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            ForEach(0..<3) { _ in
                Button(action: {}) {
                    Text("Fat Button Style")
                }
                .buttonStyle(FatButtonStyle(color: .randomExcludingBlackWhite))
            }
        }
        .padding()
        .background(Color.random)
        .previewLayout(.sizeThatFits)
    }
}
