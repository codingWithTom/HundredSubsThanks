//
//  Title.swift
//  HundredSubsThanks
//
//  Created by Tomas Trujillo on 2021-05-10.
//

import SwiftUI

struct Title: View {
  @Binding var isAnimating: Bool
  let text: String = "100 subs!"
  let cycle: Bool
  
  private var words: [String] {
    text.map { String($0) }
  }
  private var fraction: CGFloat {
    return 1.0 / CGFloat(words.count)
  }
  
  init(cycle: Bool = false, isAnimating: Binding<Bool>) {
    self.cycle = cycle
    self._isAnimating = isAnimating
  }
  
  var body: some View {
    HStack(spacing: 0.0) {
      ForEach(words.indices, id: \.self) { index in
        Text(words[index])
          .modifier(FontScaleModifier(isAnimating: isAnimating,
                                      fraction: fraction, order: index))
          .animation(cycle ?
                      isAnimating ?
                              .easeOut(duration: 1.0).repeatForever(autoreverses: false) :
                              .linear(duration: 0)
                      : .linear(duration: 1.0)
          )
          .modifier(ColorModifier(isAnimating: isAnimating))
          .animation(isAnimating ? .linear(duration: 3.0).repeatForever(autoreverses: false) : .linear(duration: 0.0))
      }
    }
  }
}
