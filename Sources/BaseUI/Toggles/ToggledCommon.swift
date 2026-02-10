//
//  ToggledCommon.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

import SwiftUI

struct ToggledViewCommon<Content: View>: View {
  
  let title: String
  @Binding var isEnabled: Bool
  let content: Content
  
  init(
    _ title: String,
    isEnabled: Binding<Bool>,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.title = title
    self._isEnabled = isEnabled
    self.content = content()
  }
  
  var body: some View {
    VStack {
      Toggle(title, isOn: $isEnabled)
        .foregroundStyle(isEnabled ? .primary : .tertiary)
      if isEnabled {
        content
      }
    }
  }
}
