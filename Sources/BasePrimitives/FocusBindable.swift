//
//  Focus.swift
//  Collection
//
//  Created by Dave Coleman on 3/2/2025.
//

import SwiftUI

/// Note: This is directly taken from Point-Free's implementation in
/// https://github.com/pointfreeco/swift-composable-architecture
/// https://github.com/pointfreeco/swift-composable-architecture/blob/20089ee985b04b1ae82e9742aa9d9c8f044700c5/Examples/CaseStudies/SwiftUICaseStudies/01-GettingStarted-FocusState.swift#L71
///
/// I make no claim over the logic behind this solution.

public protocol _Bindable {
  associatedtype Value
  var wrappedValue: Value { get nonmutating set }
}

private struct Bind<HandlerBinding: _Bindable, ViewBinding: _Bindable>: ViewModifier
where HandlerBinding.Value == ViewBinding.Value, HandlerBinding.Value: Equatable {

  @State private var hasAppeared = false
  @State private var debouncer: AsyncDebouncer?

  let handlerValue: HandlerBinding
  let viewValue: ViewBinding

  init(
    debounce: DebounceMode,
    handlerValue: HandlerBinding,
    viewValue: ViewBinding
  ) {
    self._debouncer = debounce.createDebouncer()
    self.handlerValue = handlerValue
    self.viewValue = viewValue
  }

  func body(content: Content) -> some View {
    content
      .onAppear {
        guard !self.hasAppeared else { return }
        self.hasAppeared = true

        guard self.viewValue.wrappedValue != self.handlerValue.wrappedValue else { return }

        if let debouncer {
          debouncer.execute { @MainActor in
            self.viewValue.wrappedValue = self.handlerValue.wrappedValue
          }
        } else {
          self.viewValue.wrappedValue = self.handlerValue.wrappedValue
        }
      }

      .onChange(of: self.handlerValue.wrappedValue) { _, newValue in

        if let debouncer {
          debouncer.execute { @MainActor in
            handlerDidChange(newValue)
          }
        } else {
          handlerDidChange(newValue)
        }

      }

      .onChange(of: self.viewValue.wrappedValue) { _, newValue in
        if let debouncer {
          debouncer.execute { @MainActor in
            viewDidChange(newValue)
          }
        } else {
          viewDidChange(newValue)
        }

      }
  }
}

extension Bind {
  private func viewDidChange(_ newValue: ViewBinding.Value) {
    guard self.handlerValue.wrappedValue != newValue
    else { return }
    self.handlerValue.wrappedValue = newValue
  }

  private func handlerDidChange(_ newValue: HandlerBinding.Value) {
    guard self.viewValue.wrappedValue != newValue
    else { return }
    self.viewValue.wrappedValue = newValue
  }
}

extension View {

  public func bindModel<HandlerValue: _Bindable, ViewValue: _Bindable>(
    debounce: DebounceMode,
    _ handlerValue: HandlerValue,
    to viewValue: ViewValue
  ) -> some View
  where HandlerValue.Value == ViewValue.Value, HandlerValue.Value: Equatable {
    self.modifier(
      Bind(
        debounce: debounce,
        handlerValue: handlerValue,
        viewValue: viewValue
      )
    )
  }
}

@available(iOS 15, macOS 12, tvOS 15, watchOS 8, *)
extension AccessibilityFocusState: _Bindable {}

@available(iOS 15, macOS 12, tvOS 15, watchOS 8, *)
extension AccessibilityFocusState.Binding: _Bindable {}

@available(iOS 14, macOS 11, tvOS 14, watchOS 7, *)
extension AppStorage: _Bindable {}

extension Binding: _Bindable {}

@available(iOS 14, macOS 11, tvOS 14, watchOS 7, *)
extension FocusedBinding: _Bindable {}

@available(iOS 15, macOS 12, tvOS 15, watchOS 8, *)
extension FocusState: _Bindable {}

@available(iOS 15, macOS 12, tvOS 15, watchOS 8, *)
extension FocusState.Binding: _Bindable {}

@available(iOS 14, macOS 11, tvOS 14, watchOS 7, *)
extension SceneStorage: _Bindable {}

extension State: _Bindable {}
