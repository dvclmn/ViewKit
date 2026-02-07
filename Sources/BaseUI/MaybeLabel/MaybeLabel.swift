//
//  MaybeLabel.swift
//  BaseComponents
//
//  Created by Dave Coleman on 28/2/2025.
//

import CoreTools
import SwiftUI

//extension Label {
//  public init(_ label: QuickLabel) {
//    Label {
//      Text(label.text)
//    } icon: {
//      switch label.icon {
//        case .emoji(let emojiString): Text(emojiString)
//        case .symbol(let symbolString): Image(systemName: symbolString)
//        case .customSymbol(_): Text("Custom Symbol not implemented")
//          //          Image(
//          //            ImageResource(
//          //              name: customSymbol.reference,
//          //              bundle: Bundle.module
//          //            )
//          //          )
//        case .none: EmptyView()
//      }
//    }
//  }
//}

public struct MaybeLabel: View {
  @Environment(\.labelDisplay) private var labelDisplay

  let label: QuickLabel
  let isPlain: Bool

  private let placeholderIcon: String = "eye"

  public var body: some View {

    Label {
      Text(label.text)
    } icon: {
      IconView(label.icon ?? .symbol(placeholderIcon))
    }
    /// May need to figure out a 'plain' override
    .labelStyle(.base(display: effectiveLabelDisplay))

  }
}

extension MaybeLabel {
  /// This really is the crux of what maybe label offers; a lightweight
  /// wrapper over the concept of; if no icon supplied, default to
  /// 'text-only' label style
  private var effectiveLabelDisplay: LabelDisplay? {
    hasIcon ? labelDisplay : .titleOnly
  }
  private var hasIcon: Bool { label.icon != nil }

}

// MARK: - Initialisers
extension MaybeLabel {

  public init(
    _ label: QuickLabel,
    isPlain: Bool = false
  ) {
    self.label = label
    self.isPlain = isPlain
  }

  public init(
    _ text: String,
    icon: IconLiteral? = nil,
    isPlain: Bool = false
  ) {
    let quickLabel = QuickLabel(text, icon: icon)
    self.label = quickLabel
    self.isPlain = isPlain
  }

  public init(
    _ text: String,
    symbol: String?,
    isPlain: Bool = false
  ) {
    if let symbol {
      let quickLabel = QuickLabel(text, icon: .symbol(symbol))
      self.label = quickLabel

    } else {
      self.label = QuickLabel(text, icon: nil)
    }
    self.isPlain = isPlain
  }
}
