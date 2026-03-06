//
//  ControlDescriptor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/2/2026.
//

import Foundation

public protocol ControlValue: Comparable, Strideable, BinaryFloatingPoint {}

public struct ControlDescriptor<Root, Value: ControlValue> {
  public let keyPath: WritableKeyPath<Root, Value>
  public let kind: ControlKind

  /// Optional metadata commonly needed for controls
  public let title: String?
  public let range: ClosedRange<Value>?
  public let step: Value?
  public let layout: LayoutKind?
  public let toggleConfig: ToggleConfig?

  public init(
    keyPath: WritableKeyPath<Root, Value>,
    kind: ControlKind,
    title: String? = nil,
    range: ClosedRange<Value>? = nil,
    step: Value? = nil,
    layout: LayoutKind? = nil,
    toggleConfig: ToggleConfig? = nil,
  ) {
    self.keyPath = keyPath
    self.kind = kind
    self.title = title
    self.range = range
    self.step = step
    self.layout = layout
    self.toggleConfig = toggleConfig
  }

  public func erase() -> AnyControlDescriptor<Root> {
    AnyControlDescriptor(self)
  }
}

public struct AnyControlDescriptor<Root> {
  private let _kind: ControlKind
  private let _title: String?
  private let _layout: LayoutKind?
  private let _toggleConfig: ToggleConfig?

  //  private let _applyView: (Binding<Root>) -> AnyView

  public var kind: ControlKind { _kind }
  public var title: String? { _title }
  public var layout: LayoutKind? { _layout }
  public var toggleConfig: ToggleConfig? { _toggleConfig }

  public init<Value>(_ base: ControlDescriptor<Root, Value>) {
    self._kind = base.kind
    self._title = base.title
    self._layout = base.layout
    self._toggleConfig = base.toggleConfig
  }
}

// Helper extensions to coerce Binding<Value> into specific types safely.
// In practice, you might prefer specialized generic constraints on Value instead.
//extension Binding {
//  fileprivate func asDouble() -> Binding<Double> {
//    Binding<Double>(
//      get: { (self.wrappedValue as? Double) ?? 0 },
//      set: { new in
//        if var any = self.wrappedValue as? Double {
//          any = new
//          if let casted = any as? Value {
//            self.wrappedValue = casted
//          }
//        }
//      }
//    )
//  }
//
//  fileprivate func asBool() -> Binding<Bool>? {
//    guard wrappedValue is Bool else { return nil }
//    return Binding<Bool>(
//      get: { (self.wrappedValue as? Bool) ?? false },
//      set: { new in
//        if var any = self.wrappedValue as? Bool {
//          any = new
//          if let casted = any as? Value {
//            self.wrappedValue = casted
//          }
//        }
//      }
//    )
//  }
//}
