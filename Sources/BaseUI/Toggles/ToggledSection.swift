//
//  ToggledSection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import BasePrimitives
import SwiftUI

/// New way - Type-safe with key:
/// ```
/// ToggledView(ShaderEnabledKey.self) {
///   ShaderControlsSection()
/// }
/// ```
///
/// With external binding:
/// ```
/// @State private var showAdvanced = false
/// ToggledView("Advanced Controls", binding: $showAdvanced) {
///   AdvancedSection()
/// }
/// ```
///
/// Transient (non-persisted):
/// ```
/// ToggledView("Preview Mode", transient: false) {
///   PreviewSection()
/// }
/// ```
public struct ToggledView<Content: View>: View {

  let title: String
  @OptionallyPersisted var isEnabled: Bool
  let content: () -> Content

  private init(
    configuration: ToggleConfiguration,
    @ViewBuilder content: @escaping  () -> Content
  ) {
    self.title = configuration.title
    self._isEnabled = configuration.asPropertyWrapper
    self.content = content
  }

  /// Public initializers delegate to private init
  /// Key-based initialiser (title derived from key)
  public init<K: ToggleKey>(
    _ key: K.Type,
    @ViewBuilder content:  @escaping () -> Content
  ) {
    self.init(configuration: ToggleConfiguration(key), content: content)
  }

  /// Binding-based initialiser (explicit title)
  public init(
    _ title: String = "Enabled",
    binding: Binding<Bool>,
    @ViewBuilder content: @escaping  () -> Content
  ) {
    self.init(configuration: ToggleConfiguration(title, binding: binding), content: content)
  }

  /// Transient (non-persisted) initialiser
  public init(
    _ title: String = "Enabled",
    transient defaultEnabled: Bool = true,
    @ViewBuilder content: @escaping  () -> Content
  ) {
    self.init(configuration: ToggleConfiguration(title, transient: defaultEnabled), content: content)
  }

  public var body: some View {
    ToggledViewCommon(title, isEnabled: $isEnabled) {
      content()
    }
  }
}
