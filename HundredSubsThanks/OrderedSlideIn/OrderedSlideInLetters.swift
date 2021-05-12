//
//  OrderedSlideInLetters.swift
//  HundredSubsThanks
//
//  Created by Tomas Trujillo on 2021-05-10.
//

import SwiftUI

struct OrderedSlideInLetters: View {
  @Binding var isAnimating: Bool
  let text: String
  
  private var words: [String] {
    text.map { String($0) }
  }
  
  init(_ text: String, isAnimating: Binding<Bool>) {
    self.text = text
    self._isAnimating = isAnimating
  }
  
  var body: some View {
    HStack(spacing: 0.0) {
      ForEach(words.indices, id: \.self) { index in
        let fraction = CGFloat(index) / CGFloat(words.count)
        Text(words[index])
          .opacity(isAnimating ? 1.0 : 0.0)
          .modifier(VerticalOffsetModifier(isAnimating: isAnimating, fraction: fraction))
          .animation(.easeIn(duration: 1.0))
      }
    }
  }
}
