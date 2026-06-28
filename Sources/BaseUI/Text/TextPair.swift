//
//  TextPair.swift
//  BaseComponents
//
//  Created by Dave Coleman on 1/9/2025.
//


// import LayoutKit
import SwiftUI

public struct TextPair: View {

  @Environment(\.layoutAxis) private var layoutAxis
  let first: String?
  let second: String?
  let seperator: String?

  public init(
    _ first: String?,
    _ second: String? = nil,
    seperator: String? = nil,
  ) {
    self.first = first
    self.second = second
    self.seperator = seperator
  }

  public var body: some View {

    DynamicStack(axis: layoutAxis) {
//    HStack(spacing: Styles.sizeTiny) {
//      Group {
        if let first {
          Text(first + (seperator ?? ""))
            .foregroundStyle(.tertiary)
        }

        if let second {
          Text(second)
            .foregroundStyle(.secondary)
        }
      }

      //      Spacer()
//    }
    //    .font(style.weight(.medium))
//    .fontWeight(.medium)
    //    .fixedSize(horizontal: true, vertical: false)

  }
}
//#if DEBUG
//@available(macOS 15, iOS 18, *)
//#Preview(traits: .size(.normal)) {
//  BoxPrintView()
//}
//#endif
