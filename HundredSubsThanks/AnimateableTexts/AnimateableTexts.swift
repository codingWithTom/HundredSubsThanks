//
//  AnimateableTexts.swift
//  HundredSubsThanks
//
//  Created by Tomas Trujillo on 2021-05-10.
//

import SwiftUI

struct AnimateableTexts: View {
  @State private var isAnimating: Bool = false
  private let thanks: String = "Thank you very much!"
  
  var body: some View {
    VStack(spacing: 30) {
      Title(cycle: true, isAnimating: $isAnimating)
      Spacer()
      ColorTexts(thanks, isAnimating: $isAnimating)
      Spacer()
      FlippingText(thanks, isAnimating: $isAnimating)
      Spacer()
      RandomSlideInWords(thanks, isAnimating: $isAnimating)
      Spacer()
      Button(action: { withAnimation { isAnimating.toggle() } }, label: {
        Text("Animate!")
      })
    }
  }
}

struct AnimateableTexts_Previews: PreviewProvider {
  static var previews: some View {
    AnimateableTexts()
  }
}
