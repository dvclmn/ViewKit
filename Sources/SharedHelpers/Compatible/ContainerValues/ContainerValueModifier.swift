//
//  ContainerValueModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/2/2026.
//

import SwiftUI

private struct ContainerValueModifier<T: ContainerValueCompatible>: ViewModifier {
  let type: T
  let value: T.Value
  
  func body(content: Content) -> some View {
    if #available(macOS 15, iOS 18, *) {
      content.containerValue(type.containerKeyPath, value)
    } else {
      content
    }
  }
}

extension View {
  public func containerValueBool(_ type: ContainerValueBool, _ value: Bool) -> some View {
    modifier(ContainerValueModifier(type: type, value: value))
  }
}
