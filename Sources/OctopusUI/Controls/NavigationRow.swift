//
//  NavigationRow.swift
//  OctopusKit-SwiftUI
//
//  Created by ShinryakuTako@invadingoctopus.io on 2019/9/8.
//  Copyright © 2019 Invading Octopus. Licensed under Apache License v2.0 (see LICENSE.txt)
//

//  🖥 MAC: For macOS, simply copy a symbol from the SF Symbols app and use it as any other emoji inside a string.

import SwiftUI

#if canImport(UIKit)

/// Displays a `NavigationLink` which contains an SF Symbol `Image` and a `Text` label.
public struct NavigationRow<Destination> : View where Destination: View  {
    
    public var destination: Destination
    public var imageName: String
    public var imageScale: Image.Scale = .large
    public var label: String
    
    public var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: imageName).imageScale(imageScale)
                Text(label)
                Spacer()
            }
        }
    }
}

struct NavigationRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationRow(destination: EmptyView(), imageName: "house.fill", label: "Home")
    }
}

#endif
