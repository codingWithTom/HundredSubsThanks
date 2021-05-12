//
//  OrderedSlideInTexts.swift
//  HundredSubsThanks
//
//  Created by Tomas Trujillo on 2021-05-10.
//

import SwiftUI

struct OrderedSlideInTexts: View {
  @State private var isAnimating: Bool = false
  private let thanks: String = "Thank you very much!"
  
  var body: some View {
    VStack(spacing: 30) {
      Title(cycle: true, isAnimating: $isAnimating)
      Spacer()
      OrderedSlideInWords(thanks, isAnimating: $isAnimating)
      Spacer()
      OrderedSlideInLetters(thanks, isAnimating: $isAnimating)
      Spacer()
      AlternateOrderedSlideInLetters(thanks, isAnimating: $isAnimating)
      Spacer()
      Button(action: { withAnimation { isAnimating.toggle() } }, label: {
        Text("Animate!")
      })
    }
  }
}

struct OrderedSlideInTexts_Previews: PreviewProvider {
  static var previews: some View {
    OrderedSlideInTexts()
  }
}
