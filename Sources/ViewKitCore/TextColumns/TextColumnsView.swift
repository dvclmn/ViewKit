//
//  TextColumnsView.swift
//  ViewKitCore
//
//  Created by Dave Coleman on 10/8/2025.
//

import CoreText
import SwiftUI

/// Reserves a stable number of text columns for changing, usually numeric, text.
///
/// The no-metric initializer lays out hidden zeroes with the inherited font, so
/// it follows the current font family and size without a geometry reader.
public struct TextColumns<Content: View>: View {
  @Environment(\.maxCharacterColumns) private var maxCharacterColumns
  @Environment(\.textColumnCount) private var textColumnCount

  private let columnCount: Int?
  private let sizing: Sizing
  private let alignment: Alignment
  private let content: () -> Content

  private enum Sizing {
    case characterSize(CGSize)
    case fontStyle(Font.TextStyle)
    case inheritedFont
  }

  /// Uses an explicit measured character size.
  ///
  /// This remains useful when the display font is not the system monospaced
  /// font, or when callers have already measured their own glyph advance.
  public init(
    _ columnCount: Int? = nil,
    characterSize: CGSize,
    alignment: Alignment = .center,
    @ViewBuilder content: @escaping () -> Content,
  ) {
    self.columnCount = columnCount
    self.sizing = .characterSize(characterSize)
    self.alignment = alignment
    self.content = content
  }

  /// Uses the default monospaced-digit metric for `fontStyle`.
  ///
  /// The content receives the corresponding monospaced system font, keeping
  /// the reserved columns and displayed digits in sync.
  public init(
    _ columnCount: Int? = nil,
    fontStyle: Font.TextStyle,
    alignment: Alignment = .center,
    @ViewBuilder content: @escaping () -> Content,
  ) {
    self.columnCount = columnCount
    self.sizing = .fontStyle(fontStyle)
    self.alignment = alignment
    self.content = content
  }

  /// Uses the current SwiftUI font environment without measuring view geometry.
  ///
  /// This is the preferred initializer when the content inherits its font from
  /// its surrounding hierarchy.
  public init(
    _ columnCount: Int? = nil,
    alignment: Alignment = .center,
    @ViewBuilder content: @escaping () -> Content,
  ) {
    self.columnCount = columnCount
    self.sizing = .inheritedFont
    self.alignment = alignment
    self.content = content
  }

  public var body: some View {
    reservation
      .overlay(alignment: alignment) {
        switch sizing {
          case .fontStyle(let style):
            content()
              .font(.system(style, design: .monospaced))
              .lineLimit(1)
              .fixedSize()

          case .characterSize, .inheritedFont:
            content()
              .lineLimit(1)
              .fixedSize()
              .monospacedDigit()
        }
      }
  }
}

extension TextColumns {
  @ViewBuilder
  private var reservation: some View {
    switch sizing {
      case .characterSize(let characterSize):
        Color.clear
          .frame(
            width: characterSize.width * CGFloat(columnWidth),
            height: characterSize.height,
          )

      case .fontStyle(let style):
        let metric = TextColumnMetric.monospacedDigit(for: style)
        Color.clear
          .frame(
            width: metric.advance * CGFloat(columnWidth),
            height: metric.lineHeight,
          )

      case .inheritedFont:
        /// `Text` is only for layout. It receives the hierarchy's actual font.
        Text(reservationDigits)
          .monospacedDigit()
          .lineLimit(1)
          .fixedSize()
          .hidden()
    }
  }

  private var columnWidth: Int {
    let base = columnCount ?? textColumnCount ?? maxCharacterColumns
    return min(base, maxCharacterColumns)
  }

  private var reservationDigits: String {
    String(repeating: "0", count: columnWidth)
  }
}
