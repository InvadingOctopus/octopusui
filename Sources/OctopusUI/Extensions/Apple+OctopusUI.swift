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
