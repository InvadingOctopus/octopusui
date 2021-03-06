//
//  TabLabel.swift
//  OctopusUI
//  https://github.com/InvadingOctopus/octopusui
//
//  Created by ShinryakuTako@invadingoctopus.io on 2019/9/16.
//  Copyright © 2020 Invading Octopus. Licensed under Apache License v2.0 (see LICENSE.txt)
//

//  🖥 MAC: For macOS, simply copy a symbol from the SF Symbols app and use it as any other emoji inside a string.

import SwiftUI

#if canImport(UIKit)

/// Displays a `Group` with an SF Symbol `Image` and a `Text` label. Useful for quickly setting the label of a `TabView` tab.
@available(*, deprecated, message: "Use the native Label or Text-embedded Image on newer operating systems.")
public struct TabLabel: View {
        
    public var imageName:   String
    public var imageScale:  Image.Scale = .large
    public var text:        String
    public var font:        Font = .headline
    
    public init(imageName:  String,
                imageScale: Image.Scale = .large,
                text:       String,
                font:       Font = .headline)
    {
        self.imageName  = imageName
        self.imageScale = imageScale
        self.text       = text
        self.font       = font
    }
    
    public var body: some View {
        Group {
            Image(systemName: imageName)
                .imageScale(imageScale)
            
            Text(text)
                .font(font)
        }
    }
}

/* Disabled to silence deprecation warnings on newer systems.

struct TabLabel_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            Text("Tab 1")
                .tabItem { TabLabel(imageName: "house.fill", text: "Home") }
            
            Text("Tab 2: The Revenge")
                .tabItem { TabLabel(imageName: "person.fill", text: "People") }
        }
    }
}
*/

#endif
