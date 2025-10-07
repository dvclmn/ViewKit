//
//  OverView+Buttons.swift
//  BaseComponents
//
//  Created by Dave Coleman on 20/9/2025.
//

import SwiftUI

public struct Section_Buttons: View {
  public var body: some View {
    
    Section("Buttons") {
      ExampleButton("Basic default button")
      
      ExampleButton("With base style")
        .buttonStyle(.base)
      
      
    }
    
  }
}
extension Section_Buttons {
  @ViewBuilder
  func ExampleButton(_ title: String) -> some View {
    Button {
    } label: {
      ExampleLabel(title)
    }
  }
}
