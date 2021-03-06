//
//  ContentView.swift
//  HundredSubsThanks
//
//  Created by Tomas Trujillo on 2021-05-10.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      AnimateableTexts()
        .padding(.bottom)
        .tabItem { Text("Animateable") }
      OrderedSlideInTexts()
        .padding(.bottom)
        .tabItem { Text("Slide In") }
      ScaleableTexts()
        .padding(.bottom)
        .tabItem { Text("Scaleable Texts") }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
