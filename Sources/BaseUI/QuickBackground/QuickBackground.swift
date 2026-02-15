//
//  QuickBackgroundModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 19/5/2025.
//

import CoreTools
import SwiftUI

struct QuickBackgroundModifier<S: Shape>: ViewModifier {
  @Environment(\.emphasisColour) private var emphasisColour
  @Environment(\.aspectRatioOverride) private var aspectRatioOverride
  @Environment(\.layoutPadding) private var layoutPadding
  @Environment(\.backgroundMaterial) private var backgroundMaterial
  @Environment(\.colourOverride) private var colourOverride
  @Environment(\.strokeColour) private var strokeColour
  @Environment(\.strokeWeight) private var strokeWeight
  @Environment(\.colourIntensity) private var colourIntensity

  let isEnabled: Bool
  let shape: S
  let glass: GlassTypeCompatible?
  let padding: CGFloat
  let tint: AnyShapeStyle

  func body(content: Content) -> some View {
    content
      .weightedPadding(layoutPadding ?? padding)
      .glassEffectCompatible(glass ?? .regular, in: shape, isEnabled: glass != nil)
      .background {
        if glass == nil {
          shape
            .fill(backgroundColour.opacity(colourIntensity ?? 0.3))
            .fill(material)
            .stroke(LinearGradient.lightFalloff(), lineWidth: 1)
//            .stroke(
//              strokeColour ?? AnyShapeStyle(Color.gray.opacity(0.1)),
//              lineWidth: strokeWeight ?? 1)
        }
      }

  }
}

extension QuickBackgroundModifier {
  private var backgroundColour: AnyShapeStyle {
    colourOverride ?? tint
  }

  private var material: AnyShapeStyle {
    guard isEnabled else { return .clear }
    return AnyShapeStyle(backgroundMaterial ?? .regularMaterial)
  }
}

extension View {
  /// This overload doesn't need an explicit `rounding`
  /// argument, as it's handled through `shape`
  public func quickBackground<S: Shape>(
    shape: S = .rect(cornerRadius: Styles.sizeSmall),
    glass: GlassTypeCompatible? = nil,
    padding: CGFloat = Styles.sizeTiny,
    tint: Color = Color.defaultQuickTint,
    isEnabled: Bool = true,
  ) -> some View {
    self.modifier(
      QuickBackgroundModifier(
        isEnabled: isEnabled,
        shape: shape,
        glass: glass,
        padding: padding,
        tint: AnyShapeStyle(tint),
      )
    )
  }

  public func quickRoundedBackground(
    glass: GlassTypeCompatible? = nil,
    rounding: Double = Styles.sizeSmall,
    padding: CGFloat = Styles.sizeTiny,
    tint: Color = Color.defaultQuickTint,
    isEnabled: Bool = true,
  ) -> some View {
    self.modifier(
      QuickBackgroundModifier(
        isEnabled: isEnabled,
        shape: .rect(cornerRadius: rounding),
        glass: glass,
        padding: padding,
        tint: AnyShapeStyle(tint),
      )
    )
  }
}

extension Color {
  public static var defaultQuickTint: Color { Color.black.opacity(0.2) }
}
