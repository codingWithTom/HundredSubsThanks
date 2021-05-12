//
//  AlternateOrderedSlideInLetters.swift
//  HundredSubsThanks
//
//  Created by Tomas Trujillo on 2021-05-10.
//

import SwiftUI

struct AlternateOrderedSlideInLetters: View {
  @Binding var isAnimating: Bool
  let text: String
  
  private var words: [String] {
    text.map { String($0) }
  }
  private var fraction: CGFloat {
    return 1.0 / CGFloat(words.count)
  }
  
  init(_ text: String, isAnimating: Binding<Bool>) {
    self.text = text
    self._isAnimating = isAnimating
  }
  
  var body: some View {
    HStack(spacing: 0.0) {
      ForEach(words.indices, id: \.self) { index in
        Text(words[index])
          .modifier(AlternateVerticalOffsetModifier(isAnimating: isAnimating,
                                                    fraction: fraction, order: index))
          .animation(.easeIn(duration: 1.0))
      }
    }
  }
}

struct AlternateVerticalOffsetModifier: GeometryEffect {
  private var percentage: CGFloat
  private let fraction: CGFloat
  private let order: CGFloat
  
  var animatableData: CGFloat {
    get { percentage }
    set { percentage = newValue }
  }
  
  init(isAnimating: Bool, fraction: CGFloat, order: Int) {
    self.percentage = isAnimating ? 1.0 : 0.0
    self.fraction = fraction
    self.order = CGFloat(order)
  }
  
  func effectValue(size: CGSize) -> ProjectionTransform {
    let maxOffset = size.height * 50
    let isInRange = percentage >= order * fraction && percentage <= order * fraction + fraction
    let offset: CGFloat
    if percentage == 0 {
      offset = maxOffset
    } else {
      offset = isInRange ? maxOffset * ((fraction * order + fraction) - percentage) :
        percentage >= order * fraction + fraction ? 0.0 : maxOffset
    }
    return ProjectionTransform(CGAffineTransform(translationX: 0.0, y: offset))
  }
}
