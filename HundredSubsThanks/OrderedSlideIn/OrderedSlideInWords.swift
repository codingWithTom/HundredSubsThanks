//
//  OrderedSlideInWords.swift
//  HundredSubsThanks
//
//  Created by Tomas Trujillo on 2021-05-10.
//

import SwiftUI

struct OrderedSlideInWords: View {
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
        let fraction = CGFloat(index) / CGFloat(words.count)
        Text(words[index])
          .opacity(isAnimating ? 1.0 : 0.0)
          .modifier(VerticalOffsetModifier(isAnimating: isAnimating, fraction: fraction))
          .animation(.easeIn(duration: 1.0))
      }
    }
  }
}

struct VerticalOffsetModifier: GeometryEffect {
  private var percentage: CGFloat
  private let fraction: CGFloat
  
  var animatableData: CGFloat {
    get { percentage }
    set { percentage = newValue }
  }
  
  init(isAnimating: Bool, fraction: CGFloat) {
    self.percentage = isAnimating ? 1.0 : 0.0
    self.fraction = fraction
  }
  
  func effectValue(size: CGSize) -> ProjectionTransform {
    guard percentage <= fraction else { return ProjectionTransform(.identity) }
    let offset = size.height * 50
    return ProjectionTransform(CGAffineTransform(translationX: 0.0,
                                                 y: offset * (fraction - percentage)))
  }
}
