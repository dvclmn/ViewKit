//
//  OverView+Buttons.swift
//  BaseComponents
//
//  Created by Dave Coleman on 20/9/2025.
//

// import BaseHelpers
import SharedHelpers
import SwiftUI

public struct Section_Labels: View {
  public var body: some View {

    // MARK: - Labels
    Section("Labels") {

      ExampleLabel("Default unstyled")

      ExampleLabel("Base Custom Label")
        .labelStyle(.base(display: .stacked))

      ExampleLabel("Native & Stacked")
        .labelStyle(.base)
        .environment(\.labelDisplay, .stacked)

      GroupBox("MaybeLabels") {
        MaybeLabel("Just a title")
        MaybeLabel(QuickLabel("Got an Emoji", icon: .emoji("🛼")))
        MaybeLabel("Base, w/ title & icon", icon: .symbol(Icons.getRandomIcon))
          .labelStyle(.base)
      }
      .groupBoxStyle(.custom)

    }

  }
}
