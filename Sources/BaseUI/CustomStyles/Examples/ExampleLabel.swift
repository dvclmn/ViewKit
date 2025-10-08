//
//  ExampleLabel.swift
//  BaseComponents
//
//  Created by Dave Coleman on 20/9/2025.
//


import SwiftUI

public struct ExampleLabel: View {
  @Environment(\.randomIcon) private var randomIcon
  
  let title: LocalizedStringKey
  init(_ title: String) {
    self.title = LocalizedStringKey(title)
  }
  public var body: some View {
    Label(title, systemImage: randomIcon)
      
  }
}
