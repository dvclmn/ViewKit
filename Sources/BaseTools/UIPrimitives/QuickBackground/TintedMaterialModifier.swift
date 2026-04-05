//
//  TintedMaterialModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 1/10/2025.
//

import SwiftUI
import BasePrimitives

public struct TintedMaterialModifier: ViewModifier {
  @Environment(\.backgroundMaterial) private var backgroundMaterial
  @Environment(\.contentModeOverride) private var contentModeOverride
  @Environment(\.isBackgroundExtensionEnabled) private var isBackgroundExtensionEnabled
  @Environment(\.isAnimationEnabled) private var isAnimationEnabled
  let image: Image?
  let imageIntensity: CGFloat
  let colour: Color?
  let colourIntensity: CGFloat
  let dimming: CGFloat
  public func body(content: Content) -> some View {
    content
      .background {
        ZStack {
          /// Image, if provided
          image?
            .resizable()
            .aspectRatio(nil, contentMode: contentModeOverride ?? .fill)
            .opacity(imageIntensity)

          /// Tint colour
          Rectangle()
            .fill(tintColour.opacity(colourIntensity))

          /// Material layer
          Rectangle()
            .fill(backgroundMaterial ?? .thickMaterial)

          /// Dimming layer
          Color.black.opacity(dimming)
        }
        .drawingGroup()
        .animation(isAnimationEnabled ? Styles.animationQuickNSmooth : nil, value: image)
        .animation(isAnimationEnabled ? Styles.animationQuickNSmooth : nil, value: colour)
        .backgroundExtensionCompatible(isEnabled: isBackgroundExtensionEnabled)
      }
  }
}

extension TintedMaterialModifier {

  private var tintColour: AnyShapeStyle {
    if let colour {
      AnyShapeStyle(colour)
    } else {
      AnyShapeStyle(.tint)
    }
  }
}
extension View {
  /// If no value is provided for `tint`, defaults to any
  /// explicit tint modifier set in view hierarchy. Which in
  /// turn defaults to app accent colour if not set.
  public func tintedMaterialBackground(
    image: Image? = nil,
    imageIntensity: CGFloat = 0.6,
    tint: Color? = nil,
    colourIntensity: CGFloat = 0.7,
    dimming: CGFloat = 0.55
  ) -> some View {
    self.modifier(
      TintedMaterialModifier(
        image: image,
        imageIntensity: imageIntensity,
        colour: tint,
        colourIntensity: colourIntensity,
        dimming: dimming
      )
    )
  }
}
