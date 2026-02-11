//
//  ToggledSection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import SwiftUI
import CoreTools

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
  let content: Content
  
  private init(
    configuration: ToggleConfiguration,
    @ViewBuilder content: () -> Content
  ) {
    self.title = configuration.title
    self._isEnabled = configuration.persistedValue
    self.content = content()
  }
  
  // Public initializers delegate to private init
  public init<K: ToggleKey>(
    _ key: K.Type,
    @ViewBuilder content: () -> Content
  ) {
    self.init(configuration: ToggleConfiguration(key), content: content)
  }
  
  public init(
    _ title: String = "Enabled",
    binding: Binding<Bool>,
    @ViewBuilder content: () -> Content
  ) {
    self.init(configuration: ToggleConfiguration(title, binding: binding), content: content)
  }
  
  public init(
    _ title: String = "Enabled",
    transient defaultEnabled: Bool = true,
    @ViewBuilder content: () -> Content
  ) {
    self.init(configuration: ToggleConfiguration(title, transient: defaultEnabled), content: content)
  }
  
  
//  let title: String
//  @OptionallyPersisted var isEnabled: Bool
//  let content: Content
//  
//  /// Key-based initializer (title derived from key)
//  public init<K: ToggleKey>(
//    _ key: K.Type,
//    @ViewBuilder content: () -> Content
//  ) {
//    self.title = K.displayName
//    self._isEnabled = OptionallyPersisted(key)
//    self.content = content()
//  }
//  
//  /// Binding-based initializer (explicit title)
//  public init(
//    _ title: String = "Enabled",
//    binding: Binding<Bool>,
//    @ViewBuilder content: () -> Content
//  ) {
//    self.title = title
//    self._isEnabled = OptionallyPersisted(binding: binding)
//    self.content = content()
//  }
//  
//  /// Transient (non-persisted) initializer
//  public init(
//    _ title: String = "Enabled",
//    transient defaultEnabled: Bool = true,
//    @ViewBuilder content: () -> Content
//  ) {
//    self.title = title
//    self._isEnabled = OptionallyPersisted(transient: defaultEnabled)
//    self.content = content()
//  }
  
  public var body: some View {
    ToggledViewCommon(title, isEnabled: $isEnabled) {
      content
    }
  }
}

//public struct ToggledView<Content: View>: View {
//
//  let title: String
//  @OptionallyPersisted var isEnabled: Bool
//  let content: Content
//
//  public init(
//    _ title: String = "Enabled",
//    persistenceKey: String? = nil,
//    defaultEnabled: Bool = true,
//    @ViewBuilder content: () -> Content
//  ) {
//    
//    self.title = title
//    self._isEnabled = OptionallyPersisted(
//      defaultValue: defaultEnabled,
//      persistenceKey: persistenceKey
//    )
//    self.content = content()
//  }
//
//  public var body: some View {
//
//    ToggledViewCommon(title, isEnabled: $isEnabled) {
//      content
//    }
////    VStack {
////      Toggle(title, isOn: $isEnabled)
////        .foregroundStyle(isEnabled ? .primary : .tertiary)
////      if isEnabled {
////        content
////      }
////    }
//  }
//}

//extension ToggledView {
//
//  /// The single source of truth the view will use
//  private var isEnabled: Binding<Bool> {
//    return usesPersistence ? $persistedEnabled : $transientEnabled
//  }
//
//}

//public struct ToggledViewModifier: ViewModifier {
//  
//  /// Internal ephemeral fallback
//  @State private var transientEnabled: Bool
//  @AppStorage private var persistedEnabled: Bool
//  
//  let title: String
//  private let usesPersistence: Bool
//  
//  public init(
//    _ title: String = "Enabled",
//    defaultEnabled: Bool = true,
//    persistenceKey: String? = nil,
//  ) {
//    self.title = title
//    self._transientEnabled = State(initialValue: defaultEnabled)
//    
//    if let persistenceKey {
//      self._persistedEnabled = AppStorage(wrappedValue: defaultEnabled, persistenceKey)
//      self.usesPersistence = true
//    } else {
//      
//      /// Key won't be used because usesPersistence == false
//      self._persistedEnabled = AppStorage(wrappedValue: defaultEnabled, "unused.disclosure.key")
//      self.usesPersistence = false
//    }
//  }
//  
//  public func body(content: Content) -> some View {
//    VStack {
//      Toggle(title, isOn: isEnabled)
//        .foregroundStyle(isEnabled.wrappedValue ? .primary : .tertiary)
//      if isEnabled.wrappedValue {
//        content
//      }
//    }
//  }
//}
//
//extension ToggledViewModifier {
//  
//  /// The single source of truth the view will use
//  private var isEnabled: Binding<Bool> {
//    return usesPersistence ? $persistedEnabled : $transientEnabled
//  }
//}
//
//extension View {
//  public func togglable(
//    _ title: String = "Enabled",
//    persistenceKey: String? = nil,
//    defaultEnabled: Bool = true,
//  ) -> some View {
//    self.modifier(ToggledViewModifier())
//  }
//}
