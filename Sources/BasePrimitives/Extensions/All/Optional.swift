//
//  Optional.swift
//  Helpers
//
//  Created by Dave Coleman on 31/8/2024.
//

import SwiftUI

//public func ?? <T: Sendable>(lhs: Binding<T?>, rhs: T) -> Binding<T> {
//  Binding(
//    get: { lhs.wrappedValue ?? rhs },
//    set: { lhs.wrappedValue = $0 }
//  )
//}

extension Optional {
  public var isNil: Bool {
    self == nil
  }
}

extension Optional where Wrapped: BinaryFloatingPoint {
  public var toCGFloatIfPresent: CGFloat? {
    map { CGFloat($0) }
  }
  public var toDoubleIfPresent: Double? {
    map { Double($0) }
  }
}

//extension Optional where Wrapped == Bool {
////extension Optional where Wrapped == Binding<Bool?> {
//  public func fallback(_ value: Bool) -> Binding<Bool> {
//    Binding
//  }
////  public var _boundString: String? {
////    get { self }
////    set { self = newValue }
////  }
////  public var boundString: String {
////    get { _boundString ?? "" }
////    set { _boundString = newValue.isEmpty ? nil : newValue }
////  }
//}

// MARK: - Optional bindings
/// By SwiftfulThinking
//extension Optional where Wrapped == String {
//  public var _boundString: String? {
//    get { self }
//    set { self = newValue }
//  }
//  public var boundString: String {
//    get { _boundString ?? "" }
//    set { _boundString = newValue.isEmpty ? nil : newValue }
//  }
//}

//extension Optional where Wrapped == Int {
//  public var _boundInt: Int? {
//    get { self }
//    set { self = newValue }
//  }
//
//  public var boundInt: Int {
//    get { _boundInt ?? 0 }
//    set { _boundInt = (newValue == 0) ? nil : newValue }
//  }
//}
//
extension Optional where Wrapped == Bool {
  public var _boundBool: Bool? {
    get { self }
    set { self = newValue }
  }

  public func boundBool(_ fallback: Bool = false) -> Bool {
    _boundBool ?? fallback
    //    get { _boundBool ?? fallback }
    //    set { _boundBool = newValue }
    //    set { _boundBool = (newValue == false) ? nil : newValue }
  }
}
//
//extension Optional where Wrapped == CGSize {
//  public var _boundSize: CGSize? {
//    get { self }
//    set { self = newValue }
//  }
//
//  public var boundSize: CGSize {
//    get { _boundSize ?? .zero }
//    set { _boundSize = newValue }
//  }
//
//  //  public func length(for axis: Axis2D, convention: AxisConvention = .default) -> CGFloat? {
//  //    self?.length(along: axis, convention: convention)
//  //  }
//}

//extension Optional where Wrapped == Color {
//  public var toShapeStyle: AnyShapeStyle? {
//    self.map { $0.toShapeStyle }
//  }
//}

//func ??<Bool>(lhs: Binding<Optional<Bool>>, rhs: Bool) -> Binding<Bool> {
//    Binding(
//        get: { lhs.wrappedValue ?? rhs },
//        set: { lhs.wrappedValue = $0 }
//    )
//}
