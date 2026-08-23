//
//  InfoBar+ViewExts.swift
//  ViewKit
//
//  Created by Dave Coleman on 23/8/2026.
//

import SwiftUI

extension View {
  /// Presents one InfoBar and makes it available to contributing descendants.
  ///
  /// Place this modifier as high in the hierarchy as the participating views require.
  /// Descendants contribute content with `infoBarValue`, `infoBarItem`, or the existing
  /// `infoBarItems` APIs.
  @MainActor
  public func infoBarView(isEnabled: Bool = true) -> some View {
    modifier(InfoBarItemsModifier(isEnabled: isEnabled))
  }

  //  @available(
  //    *,
  //     deprecated,
  //     renamed: "infoBarView(isEnabled:)",
  //     message: "Debouncing is no longer supported for InfoBar."
  //  )
  //  @MainActor
  //  public func infoBarView(
  //    debounceMode: DebounceMode = .debounce(0.2),
  //    isEnabled: Bool = true,
  //  ) -> some View {
  //    modifier(InfoBarItemsModifier(isEnabled: isEnabled))
  //  }
}
