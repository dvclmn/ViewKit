//
//  OverView+Buttons.swift
//  BaseComponents
//
//  Created by Dave Coleman on 20/9/2025.
import CoreTools
import ViewTools
import SwiftUI
// import LayoutKit
//import UIPrimitives

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
        QuickLabel("Just a title")
        QuickLabel(LabelDescriptor("Got an Emoji", icon: .emoji("🛼")))
        QuickLabel("Base, w/ title & icon", icon: .symbol(Icons.getRandom.icon))
          .labelStyle(.base)
      }
      .groupBoxStyle(.custom)

    }

  }
}
