//
//  AnimatedText.swift
//  OctopusUI
//
//  Created by ShinryakuTako@invadingoctopus.io on 2019/9/7.
//  Copyright © 2019 Invading Octopus. Licensed under Apache License v2.0 (see LICENSE.txt)
//

import SwiftUI
import Combine

/// Displays the specified `text` one character at a time, at the specified `animationInterval` speed.
public struct AnimatedText: View {

    // TODO: User String.Iterator?
    
    let text: String
    let animationInterval: TimeInterval
    
    @State private var currentlyDisplayedText: String = ""
    @State private var currentIndex: String.Index?
    @State private var timerCanceller: AnyCancellable?

    private var nextCharacter: Character? {
        if  let currentIndex = self.currentIndex,
            currentIndex != self.text.endIndex
        {
            return text[currentIndex]
        } else {
            return nil
        }
    }
    
    public init(_ text: String,
                animationInterval: TimeInterval = 0.015)
    {
        self.text = text
        self.animationInterval = animationInterval
    }
    
    public var body: some View {
        Text(currentlyDisplayedText)
            .onAppear(perform: startAnimation)
    }
    
    private func startAnimation() {
        
        timerCanceller = Timer.TimerPublisher(interval: animationInterval, runLoop: .main, mode: .common)
            .autoconnect()
            .sink { date in
                
                if  self.currentIndex == nil {
                    self.currentIndex = self.text.startIndex
                } else {
                    self.currentIndex! = self.text.index(after: self.currentIndex!)
                }
                                
                if  let nextCharacter = self.nextCharacter {
                    self.currentlyDisplayedText.append(nextCharacter)
                } else {
                    self.timerCanceller?.cancel()
                }
        }
    }
}

/// Preview this in live mode to see the animation.
struct AnimatedText_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
    }
}
