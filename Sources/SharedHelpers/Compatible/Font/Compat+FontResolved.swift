//
//  Compat+FontResolved.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/12/2025.
//

import SwiftUI

extension Font {
  public func resolveCompatible(in context: Font.Context) -> Font.ResolvedCompatible {
    Font.ResolvedCompatible(self, in: context)
  }
}

extension Font {
  public struct ResolvedCompatible {
    let font: Font
    let context: Font.Context
  }
}

extension Font.ResolvedCompatible {
  public init(_ font: Font, in context: Font.Context) {
    self.font = font
    self.context = context
  }

  public init?(font: Font?, context: Font.Context) {
    guard let font else { return nil }
    self.font = font
    self.context = context
  }
}

@available(macOS 26, iOS 26, *)
extension Font.ResolvedCompatible {
  public var fontResolved: Font.Resolved { font.resolve(in: context) }
  public var toNSFont: NSFont { fontResolved.ctFont as NSFont }
}
