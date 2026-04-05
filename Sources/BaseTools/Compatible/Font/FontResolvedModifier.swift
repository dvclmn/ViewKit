//
//  FontResolvedModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/12/2025.
//

import SwiftUI

/// Useful:
/// `EnvironmentValues/fontResolutionContext`
/// `Font/resolve(in:)`
///
/// `Font.Context`
/// Information used to resolve a font.
///
/// `Font.Resolved`
/// A concrete  representation of a Font that can be shown,
/// with a specific set of `EnvironmentValues`.
/// A `Resolved` font will always map to the same
/// `CTFont` on a given platform.
public struct FontResolvedModifier: ViewModifier {
  
  public func body(content: Content) -> some View {
    if #available(macOS 26, iOS 26, *) {
      content
      
    } else {
      
      content
    }
  }
}
//extension View {
//  public func example() -> some View {
//    self.modifier(ExampleModifier())
//  }
//}
