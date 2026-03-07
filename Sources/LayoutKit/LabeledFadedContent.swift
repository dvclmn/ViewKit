//
//  LabeledFadedContent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/3/2026.
//

import SwiftUI

extension LabeledContentStyle where Self == LabeledFadedContent {
  public static var fadedContent: Self { Self() }
}

public struct LabeledFadedContent: LabeledContentStyle {
  public func makeBody(configuration: Configuration) -> some View {
    LabeledContent {
      configuration.content
        .foregroundStyle(.secondary)
    } label: {
      configuration.label
    }

  }
}
