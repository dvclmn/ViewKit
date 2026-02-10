//
//  ToggledSection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import SwiftUI

public struct ToggledView<Content: View>: View {

  let title: String
  @OptionallyPersisted var isEnabled: Bool
  let content: Content

  public init(
    _ title: String = "Enabled",
    persistenceKey: String? = nil,
    defaultEnabled: Bool = true,
    @ViewBuilder content: () -> Content
  ) {
    
    self.title = title
    self._isEnabled = OptionallyPersisted(
      defaultValue: defaultEnabled,
      persistenceKey: persistenceKey
    )
    self.content = content()
  }

  public var body: some View {

    ToggledViewCommon(title, isEnabled: $isEnabled) {
      content
    }
//    VStack {
//      Toggle(title, isOn: $isEnabled)
//        .foregroundStyle(isEnabled ? .primary : .tertiary)
//      if isEnabled {
//        content
//      }
//    }
  }
}

//extension ToggledView {
//
//  /// The single source of truth the view will use
//  private var isEnabled: Binding<Bool> {
//    return usesPersistence ? $persistedEnabled : $transientEnabled
//  }
//
//}
