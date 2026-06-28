//
//  FormLabel.swift
//  Eucalypt
//
//  Created by Dave Coleman on 26/3/2024.
//


// import LayoutKit
import Foundation
import SwiftUI

public struct CustomLabeledContent: LabeledContentStyle {
  @Environment(\.layoutAxis) private var layoutAxis
  @Environment(\.layoutAlignment) private var layoutAlignment
  @Environment(\.widthOverride) private var widthOverride

  //  @Environment(\.layoutConfig) private var layoutConfig

  public func makeBody(configuration: Configuration) -> some View {

    Group {

      if layoutAxis == nil {
        Native(configuration)

      } else {
        DynamicStack(axis: layoutAxis) {
          VStack {
            configuration.label
              .foregroundStyle(.secondary.opacity(0.8))
          }

          configuration.content
            .toggleStyle(.switch)
            .controlSize(.small)
        }
      }
    }
    .frame(maxWidth: widthOverride, alignment: layoutAlignment ?? .center)

  }
}

extension CustomLabeledContent {

  @ViewBuilder
  func LayoutView(_ layout: some Layout, configuration: Configuration) -> some View {
    layout {

    }
  }

  @ViewBuilder
  func Native(_ configuration: Configuration) -> some View {
    LabeledContent {
      configuration.content
        .controlSize(.small)
        .toggleStyle(.switch)
        .frame(maxWidth: widthOverride, alignment: layoutAlignment?.toOpposing ?? .center)

    } label: {
      configuration.label

    }
  }
}

extension LabeledContentStyle where Self == CustomLabeledContent {
  public static var custom: CustomLabeledContent { CustomLabeledContent() }
}
