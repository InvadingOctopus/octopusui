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

    @Binding public var selection: Color

    public var exclude:     Set<Color> = []
    public var icon:        String = "circle.fill"
    public var showNames:   Bool = false
    public var sorted:      Bool = false

    public var colorName: String? {
        Color.presetsToNames[selection]
    }


    public init(selection:  Binding<Color>,
                exclude:    Set<Color> = [],
                icon:       String = "circle.fill",
                sorted:     Bool = false,
                showNames:  Bool = false)
    {
        self._selection = selection
        self.exclude    = exclude
        self.icon       = icon
        self.showNames  = showNames
        self.sorted     = sorted
    }


    public var body: some View {
        ForEach(Color.presets, id: \.self) { colorPreset in
            if !exclude.contains(colorPreset) {
                Button {
                    selection = colorPreset
                } label: {
                    VStack {
                        Image(systemName: icon)
                        if showNames,
                           let name = Color.presetsToNames[colorPreset] {
                            Text(name.capitalized)
                                .padding(5)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .foregroundStyle(colorPreset)
                }
            }
        }
    }
}


#Preview {
    @Previewable @State var color: Color = .red

    VStack {

        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 10) {
                ColorPicker(selection: $color, showNames: true)
            }
        }

        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 10) {
                ColorPicker(selection: $color)
            }
        }

    }
}


#Preview {
    @Previewable @State var color: Color = .red

    List {
        ColorPicker(selection: $color)
    }
    .padding()
}

