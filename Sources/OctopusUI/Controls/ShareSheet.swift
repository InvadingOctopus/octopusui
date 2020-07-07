//
//  ShareSheet.swift
//  OctopusUI
//  https://github.com/InvadingOctopus/octopusui
//
//  Created by ShinryakuTako@invadingoctopus.io on 2020/05/23.
//  ORIGINAL: SOURCE: https://github.com/AlanQuatermain/SwiftUIShareSheetDemo/blob/master/ShareSheetDemo/ShareSheet.swift
//  ORIGINAL: CREDIT: Copyright © 2019 Jim Dovey. All rights reserved. https://github.com/AlanQuatermain
//  UPDATES:  2020 Invading Octopus.
//

// TODO: macOS version

import SwiftUI

#if os(iOS)

/// Presents a sharing sheet.
@available(iOS 13.0, *)
public struct ShareSheet: UIViewControllerRepresentable {
    
    public typealias Callback = (
        _ activityType:  UIActivity.ActivityType?,
        _ completed:     Bool,
        _ returnedItems: [Any]?,
        _ error:         Error?) -> Void

    let activityItems:          [Any]
    let applicationActivities:  [UIActivity]?
    let excludedActivityTypes:  [UIActivity.ActivityType]?
    let callback:               Callback?

    public init(activityItems:  [Any],
                applicationActivities: [UIActivity]?              = nil,
                excludedActivityTypes: [UIActivity.ActivityType]? = nil,
                callback:              ShareSheet.Callback?       = nil)
    {
        self.activityItems          = activityItems
        self.applicationActivities  = applicationActivities
        self.excludedActivityTypes  = excludedActivityTypes
        self.callback               = callback
    }
    
    public func makeUIViewController(context: Context) -> UIActivityViewController {
        
        let controller = UIActivityViewController(
            activityItems:          activityItems,
            applicationActivities:  applicationActivities)
        
        controller.excludedActivityTypes        = excludedActivityTypes
        controller.completionWithItemsHandler   = callback
        return controller
    }

    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // Not needed
    }
}

#endif
