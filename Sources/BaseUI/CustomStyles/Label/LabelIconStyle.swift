//
//  LabelIconStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 28/1/2026.
//

import SwiftUI

public struct LabelIconStyle: LabelStyle {

  public func makeBody(configuration: Configuration) -> some View {
    Label {
      configuration.title
        .foregroundStyle(.primary.opacity(0.94))
    } icon: {
      configuration.icon
        .symbolVariant(.fill)
        .symbolRenderingMode(.hierarchical)
        .foregroundStyle(.primary.opacity(0.7), .tertiary)
    }

  }
}

extension LabelStyle where Self == LabelIconStyle {
  public static var lightIcon: Self { Self() }
}
