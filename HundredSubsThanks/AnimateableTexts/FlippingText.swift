//
//  FlippingText.swift
//  HundredSubsThanks
//
//  Created by Tomas Trujillo on 2021-05-10.
//

import SwiftUI

struct FlippingText: View {
  @Binding var isAnimating: Bool
  let text: String
  
  init(_ text: String, isAnimating: Binding<Bool>) {
    self.text = text
    self._isAnimating = isAnimating
  }
  
  var body: some View {
    Text(text)
      .font(.title)
      .opacity(isAnimating ? 1.0 : 0.0)
      .modifier(FlippingModifier(isAnimating: isAnimating))
      .animation(.easeInOut(duration: 2.0))
  }
}

struct FlippingModifier: GeometryEffect {
  private var percentage: CGFloat
  
  var animatableData: CGFloat {
    get { percentage }
    set { percentage = newValue }
  }
  
  init(isAnimating: Bool) {
    self.percentage = isAnimating ? 1.0 : 0.0
  }
  
  func effectValue(size: CGSize) -> ProjectionTransform {
    guard percentage != 0 && percentage != 1 else { return ProjectionTransform(.identity) }
    let totalDegress: CGFloat = (.pi * 2) * 8
    let identity = CATransform3DIdentity
    let anchorPointStart = CATransform3DTranslate(identity, size.width / 2.0, size.height / 2.0, 0.0)
    let scale = CATransform3DScale(anchorPointStart, max(0.2, percentage), max(0.2, percentage), 1.0)
    let rotate = CATransform3DRotate(scale, totalDegress * percentage, 0.0, 1.0, 0.0)
    let anchorPointFinal = CATransform3DTranslate(rotate, -size.width  / 2, -size.height / 2, 0.0)
    return ProjectionTransform(anchorPointFinal)
  }
}

