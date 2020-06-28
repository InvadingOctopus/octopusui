//
//  CollapsableGroup.swift
//  OctopusUI
//  https://github.com/InvadingOctopus/octopusui
//
//  Created by ShinryakuTako@invadingoctopus.io on 2019/9/8.
//  Copyright © 2020 Invading Octopus. Licensed under Apache License v2.0 (see LICENSE.txt)
//

import SwiftUI

/// Displays a stack that can be collapsed/uncollapsed by clicking on a chevron in the label. Useful for displaying optional controls in lists.
@available(*, deprecated, message: "Use the native DisclosureGroup on newer operating systems.")
public struct CollapsableGroup <Content, Label> : View
    where Content: View, Label: View
{
    public var label: Label
    public var content: () -> Content
    
    @State private var collapsed: Bool = false

    public init(label: Label,
                @ViewBuilder content: @escaping () -> Content)
    {
        self.label = label
        self.content = content
    }
    
    @inlinable public init(label: Label,
                           content: Content)
    {
        self.init(label: label) {
            content
        }
    }
    
    // MARK: Body
    
    public var body: some View {
        VStack {

            collapseToggleButton
            
            if !collapsed {
                content()
            }
        }
    }
    
    private var collapseToggleButton: some View {
        Button(action: {
            withAnimation { self.collapsed.toggle() }
        }) {
            HStack {
                
                label
                
                Spacer()
                
                #if canImport(AppKit)
                
                chevron
                    .rotationEffect(.degrees(collapsed ? 0 : 90))
                    .padding(.horizontal)
                
                #elseif canImport(UIKit)
                
                chevron
                    .rotationEffect(.degrees(collapsed ? 0 : 90))
                    .imageScale(.large)
                    .padding(.horizontal)
                
                #endif
            }
        }
    }
    
    // 🖥 macOS cannot use SF Symbols via Image(systemName:) but we can just copy paste them from the SF Symbols app as any other text/emoji!
    
    private var chevron: some View {
        #if canImport(UIKit)
            return Image(systemName: collapsed ? "chevron.right.circle" : "chevron.right.circle.fill")
        #else
            return Text("\(collapsed ? "􀁴" : "􀁵")")
        #endif
    }
}

/* Disabled to silence deprecation warnings on newer systems.

/// Preview in live mode to test interactivity.
struct CollapsableGroup_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            CollapsableGroup(label: Text("CollapsableGroup")) {
                ForEach (0 ..< 3) { item in
                    Text("Item \(item+1)")
                }
            }
        }
    }
}
*/

/* TODO: Enable when the Swift Package can be set to the latest OS versions.

struct CollapsableGroup_LibraryContent: LibraryContentProvider {
    @LibraryContentBuilder
    var views: [LibraryItem] {
        LibraryItem(
            CollapsableGroup(label: "Group", content: {
                Text("Content")
            }),
            category: .control
        )
    }
}
*/
