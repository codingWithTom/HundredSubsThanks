//
//  RandomSlideInWords.swift
//  HundredSubsThanks
//
//  Created by Tomas Trujillo on 2021-05-10.
//

import SwiftUI

struct RandomSlideInWords: View {
  @Binding var isAnimating: Bool
  let text: String
  
  private var words: [String] {
    text.split(separator: " ").map { String($0) }
  }
  
  init(_ text: String, isAnimating: Binding<Bool>) {
    self.text = text
    self._isAnimating = isAnimating
  }
  
  var body: some View {
    HStack {
      ForEach(words.indices, id: \.self) { index in
        Text(words[index])
          .opacity(isAnimating ? 1.0 : 0.0)
          .modifier(RandomOffsetModifier(isAnimating: isAnimating))
          .animation(.easeIn(duration: 1.0))
      }
    }
  }
}

struct RandomOffsetModifier: AnimatableModifier {
  private var percentage: CGFloat
  
  var animatableData: CGFloat {
    get { percentage }
    set { percentage = newValue }
  }
  private let offSet: CGPoint
  private var xOffset: CGFloat {
    offSet.x - offSet.x * percentage
  }
  private var yOffset: CGFloat {
    offSet.y - offSet.y * percentage
  }
  
  init(isAnimating: Bool) {
    self.percentage = isAnimating ? 1.0 : 0.0
    self.offSet = CGPoint(x: .random(in: -100 ... 100), y: .random(in: -100 ... 100))
  }
  
  func body(content: Content) -> some View {
    content
      .offset(x: xOffset, y: yOffset)
  }
}
