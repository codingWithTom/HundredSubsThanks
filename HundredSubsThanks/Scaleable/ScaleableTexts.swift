//
//  ScaleableTexts.swift
//  HundredSubsThanks
//
//  Created by Tomas Trujillo on 2021-05-10.
//

import SwiftUI

struct ScaleableTexts: View {
  @State private var isAnimating: Bool = false
  private let thanks: String = "🎊Thank you very much!🎊"
  
  var body: some View {
    VStack(spacing: 30) {
      Title(cycle: true, isAnimating: $isAnimating)
      Spacer()
      ScaleableText(thanks, isAnimating: $isAnimating)
      Spacer()
      ScaleableText(thanks, cycle: true, isAnimating: $isAnimating)
      Spacer()
      Button(action: { withAnimation { isAnimating.toggle() } }, label: {
        Text("Animate!")
      })
    }
  }
}

struct ScaleableText: View {
  @Binding var isAnimating: Bool
  let text: String
  let cycle: Bool
  
  private var words: [String] {
    text.map { String($0) }
  }
  private var fraction: CGFloat {
    return 1.0 / CGFloat(words.count)
  }
  
  init(_ text: String, cycle: Bool = false, isAnimating: Binding<Bool>) {
    self.text = text
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
      }
    }
  }
}

struct FontScaleModifier: AnimatableModifier {
  private var percentage: CGFloat
  private let fraction: CGFloat
  private let order: CGFloat
  
  var animatableData: CGFloat {
    get { percentage }
    set { percentage = newValue }
  }
  
  var size: CGFloat {
    guard percentage != 0 && percentage != 1 else { return 1.0 }
    let isInRange = percentage >= order * fraction && percentage <= order * fraction + fraction
    return isInRange ? 2.0 : 1.0
  }
  
  init(isAnimating: Bool, fraction: CGFloat, order: Int) {
    self.percentage = isAnimating ? 1.0 : 0.0
    self.fraction = fraction
    self.order = CGFloat(order)
  }
  
  func body(content: Content) -> some View {
    content
      .scaleEffect(x: size, y: size)
  }
}

struct ScaleableTexts_Previews: PreviewProvider {
  static var previews: some View {
    ScaleableTexts()
  }
}
