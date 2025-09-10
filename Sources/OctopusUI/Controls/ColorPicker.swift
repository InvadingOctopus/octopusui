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
where ShapeView: InsettableShape {

    @Binding public var selection: Color

    public var showNames:  Bool = false
    public var sorted:     Bool = false

    @ViewBuilder var shape: ShapeView

    public var colorName: String? {
        Color.presetsToNames[selection]
    }

    public init(color:      Binding<Color>,
                showNames:  Bool = false,
                sorted:     Bool = false,
                @ViewBuilder shape: () -> ShapeView) {
        self._selection     = color
        self.showNames  = showNames
        self.sorted     = sorted
        self.shape    = shape()
    }


    public var body: some View {
        ForEach(Color.presets,
                id: \.self)
        { colorPreset in
            Button {
                selection = colorPreset
            } label: {
                VStack {
                    shape
                    if showNames,
                       let name = Color.presetsToNames[colorPreset] {
                        Text(name)
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


// + Convenience initializer for using a RoundedRectangle as the default shape.
public extension ColorPicker where ShapeView == Capsule {
    init(color:      Binding<Color>,
         showNames:  Bool = false,
         sorted:     Bool = false)
    {
        self.init(color: color,
                  showNames: showNames,
                  sorted: sorted) {
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
                            showNames: true)
            }
        }

        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 10) {
                ColorPicker(color: $color)
            }
        }

    }
    .padding()
}


#Preview {
    @Previewable @State var color: Color = .red

    List {
        ColorPicker(color: $color)
    }
    .padding()
}
