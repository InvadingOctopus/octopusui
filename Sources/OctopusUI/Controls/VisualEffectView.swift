//
//  VisualEffectView.swift
//  OctopusUI
//  https://github.com/InvadingOctopus/octopusui
//
//  Created by ShinryakuTako@invadingoctopus.io on 2019/9/13.
//  Copyright © 2020 Invading Octopus. Licensed under Apache License v2.0 (see LICENSE.txt)
//

import SwiftUI

#if canImport(AppKit)

/// Encapsulates an `NSVisualEffectView` for blur and transparency effects.
public struct VisualEffectView: NSViewRepresentable {

    public var material: NSVisualEffectView.Material = .appearanceBased
    public var blendingMode: NSVisualEffectView.BlendingMode
    public var state: NSVisualEffectView.State = .followsWindowActiveState
    
    public init(material: NSVisualEffectView.Material = .appearanceBased,
                blendingMode: NSVisualEffectView.BlendingMode,
                state: NSVisualEffectView.State = .followsWindowActiveState)
    {
        self.material = material
        self.blendingMode = blendingMode
        self.state = state
    }
    
    public func makeNSView(context: NSViewRepresentableContext<VisualEffectView>) -> NSVisualEffectView {
        let visualEffectView = NSVisualEffectView()
        visualEffectView.material = material
        visualEffectView.blendingMode = blendingMode
        visualEffectView.state = state
        
        return visualEffectView
    }
    
    public func updateNSView(_ nsView: NSVisualEffectView, context: NSViewRepresentableContext<VisualEffectView>) {
    }
}

struct VisualEffectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            VisualEffectView(material: .appearanceBased,
                             blendingMode: .behindWindow)
            Text("VisualEffectView")
        }
    }
}

#elseif canImport(UIKit)

/// Encapsulates a `UIVisualEffectView` for blur and transparency effects.
public struct VisualEffectView: UIViewRepresentable {
    
    public var effect: UIVisualEffect = UIBlurEffect(style: .systemMaterial)
    
    public init(effect: UIVisualEffect = UIBlurEffect(style: .systemMaterial)) {
        self.effect = effect
    }
    
    public func makeUIView(context: UIViewRepresentableContext<VisualEffectView>) -> UIView {
        
        let visualEffectView = UIVisualEffectView(effect: effect)
        
        return visualEffectView
    }
    
    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<VisualEffectView>) {
    }
}

struct VisualEffectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            VisualEffectView(effect: UIBlurEffect(style: .dark))
            Text("VisualEffectView")
        }
    }
}

#endif

