//
//  Apple+OctopusUI.swift
//  OctopusUI
//  https://github.com/InvadingOctopus/octopusui
//
//  Created by ShinryakuTako@invadingoctopus.io on 2023/07/06.
//  Copyright © 2023 Invading Octopus. Licensed under Apache License v2.0 (see LICENSE.txt)
//

import Foundation
import SwiftUI


public extension Date {
    // TODO: Move to OctopusCore
    
    var oneHourAgo: Date {
        self.addingTimeInterval(-3600) // (60 * 60)
    }

    var oneDayAgo: Date {
        self.addingTimeInterval(-86400) // (60 * 60 * 24)
    }

    var oneWeekAgo: Date {
        self.addingTimeInterval(-604800) // (60 * 60 * 24 * 7)
    }

    var isInLastHour: Bool {
        self.timeIntervalSinceNow >= -3600 // (60 * 60)
    }

    var isInToday: Bool {
        self.timeIntervalSinceNow >= -86400 // (60 * 60 * 24)
    }
}


extension String: @retroactive View {
    
    /// This extension allows a standalone `String` to be used as a `Text` view in a SwiftUI layout.
    ///
    /// **Example:**
    ///
    ///     VStack {
    ///         "A string which will be used as a Text view."
    ///     }
    public var body: some View {
        Text(self)
    }
    
}
