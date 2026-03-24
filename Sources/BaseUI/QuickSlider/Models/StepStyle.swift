//
//  StepStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/2/2026.
//

public enum StepStyle {
  case native // Notched slider track
  case stepper  // Adds explicit stepper buttons
}


//public enum StepStyle<Value: BinaryFloatingPoint & Sendable> {
//  case native(stepSize: Value)  // Notched slider track
//  case stepper(stepSize: Value)  // Adds explicit stepper buttons
//  case none
//}
//
//extension StepStyle: ExpressibleByFloatLiteral {
//  public init(floatLiteral value: FloatLiteralType) {
//    self = .native(stepSize: Value(value))
//  }
//  public init(fromOptionalValue value: Value?) {
//    if let value {
//      self = .native(stepSize: value)
//    } else {
//      self = .none
//    }
//  }
//}
