//
//  CycleButton.swift
//  OctopusUI
//
//  Created by ShinryakuTako@invadingoctopus.io on 2019/9/7.
//  Copyright © 2019 Invading Octopus. Licensed under Apache License v2.0 (see LICENSE.txt)
//

import SwiftUI

/// A button which cycles between the cases of an enum.
public struct CycleButton<EnumType>: View
    where EnumType: RawRepresentable & Equatable,
    EnumType.RawValue == String
{
    @Binding public var selection: EnumType
    
    public let options: [EnumType]
    
    public var prefix: String? = nil
    public var suffix: String? = nil
    
    public var body: some View {
        Button(action: cycle) {
            Text("\(prefix ?? "")\(selection.rawValue)\(suffix ?? "")")
        }
        .foregroundColor(Color(.white))
        .padding(5)
        .background(Color.accentColor)
        .cornerRadius(5)
    }
    
    func cycle() {
        guard options.count > 1 else { return }

        let currentCaseIndex = options.firstIndex(of: selection)
        var nextCaseIndex = (currentCaseIndex ?? 0) + 1
        
        if nextCaseIndex >= options.endIndex { nextCaseIndex = 0 }
        
        self.selection = options[nextCaseIndex]
    }
}

/// Preview in live mode to test interactivity.
struct CycleButton_Previews: PreviewProvider {
    
    enum Option: String, CaseIterable {
        case one = "Option One"
        case two = "Option 2"
        case three = "Option 三"
        case four = "Option IV"
    }
    
    static var previews: some View {
        ChildPreview()
    }
    
    /// We use a child struct because `static var previews` cannot access an instance variable for the `selection` binding.
    struct ChildPreview: View {
        
        @State var selection = Option.one
        
        var body: some View {
            VStack {
                CycleButton(selection: $selection, options: Option.allCases)
            }
            .padding()
        }
    }
}
