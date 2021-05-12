//
//  ColorTexts.swift
//  HundredSubsThanks
//
//  Created by Tomas Trujillo on 2021-05-10.
//

import SwiftUI

struct ColorTexts: View {
  @Binding var isAnimating: Bool
  let text: String
  
  init(_ text: String, isAnimating: Binding<Bool>) {
    self.text = text
    self._isAnimating = isAnimating
  }
  var body: some View {
    Text(text)
      .font(.title)
      .modifier(ColorModifier(isAnimating: isAnimating))
      .animation(isAnimating ?
                  .linear(duration: 0.6).repeatForever(autoreverses: false) :
                  .linear(duration: 0.0)
      )
  }
}

struct ColorModifier: AnimatableModifier {
  private var percentage: CGFloat
  
  var animatableData: CGFloat {
    get { percentage }
    set { percentage = newValue }
  }
  
  private var color: Color {
    switch percentage {
    case 0.001 ..< 0.2:
      return .blue
    case 0.2 ..< 0.4:
      return .red
    case 0.4 ..< 0.6:
      return .yellow
    case 0.6 ..< 0.8:
      return .green
    case 0.8 ..< 1.0:
      return .orange
    default:
      return .black
    }
  }
  
  init(isAnimating: Bool) {
    self.percentage = isAnimating ? 1.0 : 0.0
  }
  
  func body(content: Content) -> some View {
    content
      .foregroundColor(color)
  }
}

struct ColorTexts_Previews: PreviewProvider {
  static var previews: some View {
    ColorTexts("Thanks!", isAnimating: .constant(false))
  }
}
