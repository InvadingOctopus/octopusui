//
//  ColorChooser.swift
//  OctopusUI
//  https://github.com/InvadingOctopus/octopusui
//
//  Created by ShinryakuTako@invadingoctopus.io on 2025/08/31.
//  Copyright © 2025 Invading Octopus. Licensed under Apache License v2.0 (see LICENSE.txt)
//

// TODO: Show selection status

import SwiftUI


/// Presents a list of `Button`s for choosing a `Color`.
/// May be embedded in any container like `HStack` or `List`.
public struct ColorPicker: View {
    @Binding public var color:     Color
    @Binding public var colorName: String

    public var showNames:  Bool = false
    public var sorted:     Bool = false
    public var size:       CGFloat = 24


    public init(color:      Binding<Color>,
                colorName:  Binding<String>,
                showNames:  Bool = false,
                sorted:     Bool = false,
                size:       CGFloat = 24)
    {
        self._color     = color
        self._colorName = colorName
        self.showNames  = showNames
        self.sorted     = sorted
        self.size       = size
    }


    public var body: some View {
        ForEach(sorted ? Color.Name.allCasesSorted : Color.Name.allCases,
                id: \.rawValue)
        { name in
            Button {
                color = name.color
                colorName = name.rawValue
            } label: {
                if showNames {
                    Text(name.rawValue.capitalized)
                        .padding(5)
                        .frame(maxWidth: .infinity)
                } else {
                    Capsule(style: .continuous)
//                        .fixedSize(horizontal: false, vertical: true)
                        .frame(height: size)
                }
            }
//            .buttonBorderShape(.capsule)
            .foregroundStyle(name.color)
        }
    }
}


#Preview {
    @Previewable @State var color: Color = .red
    @Previewable @State var colorName: String = "Red"

    VStack {

        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 10) {
                ColorPicker(color: $color,
                             colorName: $colorName,
                             showNames: true)
            }
        }

        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 10) {
                ColorPicker(color: $color,
                             colorName: $colorName)
            }
        }

    }
    .padding()
}


#Preview {
    @Previewable @State var color: Color = .red
    @Previewable @State var colorName: String = "Red"

    List {
        ColorPicker(color: $color,
                     colorName: $colorName)
    }
    .padding()
}
