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
public struct ColorPicker<WellContent: View>: View {

    @Binding public var selection: Color

    public let exclude: Set<Color>
    public let sorted:  Bool
    public let well:    (Color, Bool) -> WellContent

    private let choices:[Color]

    public var selectedColorName: String? {
        Color.presetsToNames[selection]
    }


    public init(selection:  Binding<Color>,
                exclude:    Set<Color> = [],
                sorted:     Bool = false,
                @ViewBuilder well:  @escaping (Color, Bool) -> WellContent)
    {
        self._selection = selection
        self.exclude    = exclude
        self.sorted     = sorted
        self.well       = well

        if sorted {
            self.choices = Color.presets.filter { !exclude.contains($0) }
        } else {
            self.choices = Color.presets.filter { !exclude.contains($0) }.sorted(by: {
                (Color.presetsToNames[$0] ?? "") < (Color.presetsToNames[$1] ?? "")
            })
        }
    }


    public var body: some View {
        ForEach(choices, id: \.self) { color in
            let isSelected: Bool = selection == color

            Button {
                withAnimation(.spring) {
                    selection = color
                }
            } label: {
                well(color, isSelected)
            } //~ Button
            .buttonStyle(.plain)

        } //~ ForEach
    }
}


public extension ColorPicker where WellContent == IconColorWell {

    init(selection: Binding<Color>,
         exclude:   Set<Color> = [],
         sorted:    Bool = false,
         icon:      String = "circle.fill",
         showNames: Bool = false)
    {
        self.init(selection:selection,
                  exclude:  exclude,
                  sorted:   sorted) { color, isSelected in
            IconColorWell(color:        color,
                          icon:         icon,
                          showName:     showNames,
                          isSelected:   isSelected)
        }
    }
}


public struct CircleColorWell: View {
    public let color:       Color
    public let isSelected:  Bool

    public var body: some View {
        Circle()
            .fill(color)
            .overlay(
                Circle()
                    .fill(.clear)
                    .stroke(color.mix(with: Color.primary, by: 0.5), lineWidth: isSelected ? 3 : 0)
                    .scaleEffect(1.2)
                    .opacity(0.75)
            )
            .scaleEffect(isSelected ? 1.2 : 1.0)
    }
}


public struct SquareColorWell: View {
    public let color:       Color
    public let isSelected:  Bool

    public var body: some View {
        RoundedRectangle(cornerRadius: 10, style: .circular)
            .fill(color)
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .circular)
                    .fill(.clear)
                    .stroke(color.mix(with: Color.primary, by: 0.5), lineWidth: isSelected ? 3 : 0)
                    .scaleEffect(1.2)
                    .opacity(0.75)
            )
            .scaleEffect(isSelected ? 1.2 : 1.0)
    }
}


public struct IconColorWell: View {
    public let color:      Color
    public let icon:       String
    public let showName:   Bool
    public let isSelected: Bool

    public var body: some View {
        VStack {

            Image(systemName: icon)
                .resizable()
                .imageScale(.large)
                .scaledToFit()

            if showName, let name = Color.presetsToNames[color] {
                Text(name.capitalized)
                    .padding(5)
                    .frame(maxWidth: .infinity)
                    .bold(isSelected)
            }
        } //~ VStack
        .padding(5)
        .foregroundStyle(color)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .circular)
                .foregroundStyle(isSelected ? Color(.systemFill) : .clear)
                .opacity(0.75)
                .blendMode(.normal)
        }
    }
}


#Preview {
    @Previewable @State var selectedColor: Color = .random

    VStack(spacing: 100) {

        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 20) {
                ColorPicker(selection: $selectedColor) { color, isSelected in
                    CircleColorWell(color: color, isSelected: isSelected)
                        .frame(width: 64, height: 64)
                }
            }
        }

        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 20) {
                ColorPicker(selection: $selectedColor, exclude: [.black], sorted: true) { color, isSelected in
                    SquareColorWell(color: color, isSelected: isSelected)
                        .frame(width: 64, height: 64)
                }
            }
        }

        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 10) {
                ColorPicker(selection: $selectedColor, icon: "heart.fill", showNames: true)
                    .frame(width: 96, height: 96)
            }
        }

    }
    .scrollIndicators(.never)
    .scrollClipDisabled()
    .safeAreaPadding()
}

