//
//  GlobalUtility.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/6/2025.
//

import Foundation

@discardableResult
public func updateIfChanged<T: Equatable>(
  _ target: inout T,
  to newValue: T
) -> Bool {
  guard target != newValue else { return false }
  target = newValue
  return true
}

@discardableResult
public func updateIfChanged<T: Equatable>(
  _ target: inout T?,
  to newValue: T
) -> Bool {
  guard target != newValue else { return false }
  target = newValue
  return true
}

@discardableResult
public func updateIfNil<T: Equatable>(
  _ target: inout T?,
  to newValue: T
) -> Bool {
  if target == nil {
    target = newValue
    return true
  }
  return false
}

/// ```
/// performIfChanged(oldValue, newValue,
///   perform: didUpdateScrollContext(newValue)
/// )
/// ```
/// Or with an explicit closure
/// ```
/// performIfChanged(oldValue, newValue) {
///   didUpdateScrollContext(newValue)
/// )
/// ```
@discardableResult
public func performIfChanged<T: Equatable>(
  _ oldValue: T,
  _ newValue: T,
  perform: @autoclosure () -> Void
) -> Bool {
  guard oldValue != newValue else { return false }
  perform()
  return true
}

//@discardableResult
//public func performIfNil<T: Equatable>(
//  _ oldValue: T?,
//  _ newValue: T,
//  perform: @autoclosure () -> Void
//) -> Bool {
//  if oldValue == nil {
//    oldValue = newValue
//    return true
//  }
//  return false
////  guard oldValue != newValue else { return false }
////  perform()
////  return true
//}


@discardableResult
public func updateIfChanged<Root, Value: Equatable>(
  _ object: inout Root,
  at keyPath: WritableKeyPath<Root, Value>,
  to newValue: Value
) -> Bool {
  guard object[keyPath: keyPath] != newValue else { return false }
  object[keyPath: keyPath] = newValue
  return true
}

@discardableResult
public func updateIfChanged<Root, Value: Equatable>(
  _ object: inout Root,
  at keyPath: WritableKeyPath<Root, Value?>,
  to newValue: Value
) -> Bool {
  guard object[keyPath: keyPath] != newValue else { return false }
  object[keyPath: keyPath] = newValue
  return true
}

//@discardableResult
//public func updateIfChanged<T: Equatable>(_ newValue: T, into target: inout T) -> Bool {
//  guard target != newValue else { return false }
//  target = newValue
//  return true
//}
//
//public func updateOptionalIfChanged<T: Equatable>(_ value: T, into target: inout T?) -> Bool {
//  guard target != value else { return false }
//  target = value
//  return true
//}
//
//@discardableResult
//public func updateIfChanged<Root, Value: Equatable>(
//  _ newValue: Value,
//  on object: inout Root,
//  keyPath: WritableKeyPath<Root, Value>
//) -> Bool {
//  guard object[keyPath: keyPath] != newValue else { return false }
//  object[keyPath: keyPath] = newValue
//  return true
//}

@discardableResult
public func updateIfChangedWithOptionalRoot<Root, Value: Equatable>(
  _ newValue: Value,
  on object: inout Root?,
  keyPath: WritableKeyPath<Root, Value>
) -> Bool {
  guard object?[keyPath: keyPath] != newValue else { return false }
  object?[keyPath: keyPath] = newValue
  return true
}


/// ```
/// runIfChanged(newZoom, comparedTo: store.canvasState.zoom) {
///   print("Zoom changed, do something")
/// }
/// ```
//@discardableResult
//public func runIfChanged<T: Equatable>(
//  _ newValue: T,
//  comparedTo currentValue: T,
//  perform action: () -> Void
//) -> Bool {
//  guard newValue != currentValue else { return false }
//  action()
//  return true
//}
