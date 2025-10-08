//
//  File.swift
//
//
//  Created by Dave Coleman on 24/7/2024.
//

import BaseHelpers
import SwiftUI
import Grainient
import SharedHelpers

extension PreviewTrait where T == Preview.ViewTraits {
  public static func size(_ width: PreviewWidth, _ height: PreviewHeight = .normal) -> Self {
    .fixedLayout(width: width.value, height: height.value)
  }
}

@available(macOS 15, iOS 18, *)
extension PreviewTrait where T == Preview.ViewTraits {
  public static var grainient: PreviewTrait {
    .modifier(GrainientPreviewModifier())
  }

  public static func grainient(_ width: PreviewWidth) -> PreviewTrait {
    .modifier(GrainientPreviewModifier(width: width))
  }
}

public struct GrainientPreviewModifier: PreviewModifier {

  public var hasGrainient: Bool
  public var width: PreviewWidth
  public var height: PreviewHeight

  public init(
    hasGrainient: Bool = true,
    width: PreviewWidth = .normal,
    height: PreviewHeight = .normal
  ) {
    self.hasGrainient = hasGrainient
    self.width = width
    self.height = height
  }

  public func body(content: Content, context: Void) -> some View {
    content
      #if canImport(AppKit)
    .padding(.top, isPreview ? 1 : 0)
    .frame(width: width.value, height: width.value)
      #endif
      .grainient(
        seed: Grainient.gardenLayers.seed,
        isEnabled: hasGrainient,
        uiDimming: 0.6
      )
  }
}
