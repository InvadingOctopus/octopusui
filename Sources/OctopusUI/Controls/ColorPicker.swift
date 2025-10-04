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
public struct ColorPicker<ShapeView>: View
where ShapeView: View & Shape {

    @Binding public var selection: Color

    public var exclude:    Set<Color> = []
    public var showNames:  Bool = false
    public var sorted:     Bool = false

    @ViewBuilder var shape: ShapeView

    public var colorName: String? {
        Color.presetsToNames[selection]
    }

    public init(color:      Binding<Color>,
                exclude:    Set<Color> = [],
                showNames:  Bool = false,
                sorted:     Bool = false,
                @ViewBuilder shape: () -> ShapeView) {
        self._selection = color
        self.exclude    = exclude
        self.showNames  = showNames
        self.sorted     = sorted
        self.shape      = shape()
    }


    public var body: some View {
        ForEach(Color.presets, id: \.self) { colorPreset in
            if !exclude.contains(colorPreset) {
                Button {
                    selection = colorPreset
                } label: {
                    VStack {
                        shape
                        if showNames,
                           let name = Color.presetsToNames[colorPreset] {
                            Text(name.capitalized)
                                .padding(5)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .contentShape(shape) // CHECK: Necessary?
                    .foregroundStyle(colorPreset)
                }
            }
        }
    }
}


// + Convenience initializer for using a Capsule as the default shape.
public extension ColorPicker where ShapeView == Capsule {
    init(color:      Binding<Color>,
         exclude:    Set<Color> = [],
         showNames:  Bool = false,
         sorted:     Bool = false)
    {
        self.init(color:     color,
                  exclude:   exclude,
                  showNames: showNames,
                  sorted:    sorted) {
            Capsule(style: .continuous)
        }
    }
}


#Preview {
    @Previewable @State var color: Color = .red

    VStack {

        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 10) {
                ColorPicker(color: $color,
                            showNames: true) {
                    Circle()
                }
            }
        }

        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 10) {
                ColorPicker(color: $color)
            }
        }

    }
}


#Preview {
    @Previewable @State var color: Color = .red

    List {
        ColorPicker(color: $color)
    }
    .padding()
}

