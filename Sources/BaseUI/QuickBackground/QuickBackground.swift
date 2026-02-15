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
  @Environment(\.horizontalBias) private var horizontalBias
  @Environment(\.backgroundMaterial) private var backgroundMaterial
  @Environment(\.colourOverride) private var colourOverride
  @Environment(\.strokeColour) private var strokeColour
  @Environment(\.strokeWeight) private var strokeWeight

  let isEnabled: Bool
  let shape: S
  let padding: CGFloat?
  let hasOpticalAdjustment: Bool

  func body(content: Content) -> some View {
    content
      .padding(.horizontal, paddingH)
      .padding(.vertical, paddingV)
      .padding(.bottom, opticalPadding)

      .background {
        if #available(macOS 14.0, *) {
          shape
            .fill(backgroundColour)
            .fill(material)
            .stroke(
              strokeColour ?? AnyShapeStyle(Color.gray.opacity(0.1)),
              lineWidth: strokeWeight ?? 1)
        } else {

          shape
            .fill(backgroundColour)
          //          .fill(tintColour)

          shape
            .fill(material)

          shape
            .stroke(
              strokeColour ?? AnyShapeStyle(Color.gray.opacity(0.1)),
              lineWidth: strokeWeight ?? 1)

          // Fallback on earlier versions
        }
      }

  }
}

//
extension QuickBackgroundModifier {
  private var backgroundColour: AnyShapeStyle {
    colourOverride.withFallback(.black.opacity(0.6))
  }
  private var basePadding: CGFloat {
    return padding ?? layoutPadding ?? CGFloat.defaultQuickPadding
  }

  /// Adds some extra width to the H axis for balance
  private var hBias: CGFloat { horizontalBias ?? 2.6 }
  private var paddingH: CGFloat { basePadding * hBias }
  private var paddingV: CGFloat { basePadding }
  private var opticalPadding: CGFloat { hasOpticalAdjustment ? (paddingV / 2) : 0 }

  private var material: AnyShapeStyle {
    guard isEnabled else { return .clear }
    return AnyShapeStyle(backgroundMaterial ?? .regularMaterial)
  }
}

extension View {
  /// This overload doesn't need an explicit `rounding`
  /// argument, as it's handled through `shape`
  public func quickBackground<S: Shape>(
    shape: S = .rect(cornerRadius: CGFloat.defaultQuickRounding),
    padding: CGFloat? = nil,
    //    tint: Color = Color.defaultQuickTint,
    isEnabled: Bool = true,
    hasOpticalAdjustment: Bool = true
  ) -> some View {
    self.modifier(
      QuickBackgroundModifier(
        isEnabled: isEnabled,
        shape: shape,
        //        tint: tint,
        padding: padding,
        hasOpticalAdjustment: hasOpticalAdjustment,
      )
    )
  }

  public func quickBackground(
    rounding: CGFloat,
    //    tint: Color = Color.defaultQuickTint,
    isEnabled: Bool = true,
    hasOpticalAdjustment: Bool = true
  ) -> some View {
    self.modifier(
      QuickBackgroundModifier(
        isEnabled: isEnabled,
        shape: .rect(cornerRadius: rounding),
        //        tint: tint,
        padding: nil,
        hasOpticalAdjustment: hasOpticalAdjustment,
      )
    )
  }

  public func quickBackground(
    padding: CGFloat,
    //    tint: Color = Color.defaultQuickTint,
    isEnabled: Bool = true,
    hasOpticalAdjustment: Bool = true
  ) -> some View {
    self.modifier(
      QuickBackgroundModifier(
        isEnabled: isEnabled,
        shape: .rect(cornerRadius: Styles.sizeTiny),
        //        tint: tint,
        padding: padding,
        hasOpticalAdjustment: hasOpticalAdjustment,
      )
    )
  }
}

extension CGFloat {
  public static var defaultQuickRounding: CGFloat { Styles.sizeTiny }
  public static var defaultQuickPadding: CGFloat { 3.0 }
}

extension Color {
  public static var defaultQuickTint: Color { Color.black.opacity(0.2) }
}
