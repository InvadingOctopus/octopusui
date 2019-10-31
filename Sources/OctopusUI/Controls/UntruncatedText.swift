//
//  UntruncatedText.swift
//  OctopusKit-SwiftUI
//
//  Created by ShinryakuTako@invadingoctopus.io on 2019/9/13.
//  Copyright © 2019 Invading Octopus. Licensed under Apache License v2.0 (see LICENSE.txt)
//

//  CHECK: Not sure if this is still needed.

import SwiftUI

/// A `Text` view with a `lineLimit` of `100` and a `fixedSize` modifier.
public struct UntruncatedText: View {
    public var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(text)
            .lineLimit(100)
            .fixedSize(horizontal: false, vertical: true)
    }
}

struct NontruncatedText_Previews: PreviewProvider {
    static var previews: some View {
        UntruncatedText("beep boop")
    }
}
