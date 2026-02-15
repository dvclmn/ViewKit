//
//  QuickBackgroundModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 19/5/2025.
//

import BasePrimitives
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
  let padding: CGFloat
  let tint: AnyShapeStyle

  func body(content: Content) -> some View {
    content
      .weightedPadding(layoutPadding ?? padding)
      .background {
        shape
          .fill(backgroundColour.opacity(colourIntensity ?? 0.3))
          .fill(material)
          .stroke(
            strokeColour ?? AnyShapeStyle(Color.gray.opacity(0.1)),
            lineWidth: strokeWeight ?? 1)
      }

  }
}

//
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
    padding: CGFloat = Styles.sizeTiny,
    tint: Color = Color.defaultQuickTint,
    isEnabled: Bool = true,
  ) -> some View {
    self.modifier(
      QuickBackgroundModifier(
        isEnabled: isEnabled,
        shape: shape,
        padding: padding,
        tint: AnyShapeStyle(tint),
      )
    )
  }

  public func quickRoundedBackground(
    rounding: Double = Styles.sizeSmall,
    padding: CGFloat = Styles.sizeTiny,
    tint: Color = Color.defaultQuickTint,
    isEnabled: Bool = true,
  ) -> some View {
    self.modifier(
      QuickBackgroundModifier(
        isEnabled: isEnabled,
        shape: .rect(cornerRadius: rounding),
        padding: padding,
        tint: AnyShapeStyle(tint),
      )
    )
  }
}

extension Color {
  public static var defaultQuickTint: Color { Color.black.opacity(0.2) }
}
