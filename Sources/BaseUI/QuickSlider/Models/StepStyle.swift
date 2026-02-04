//
//  StepStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/2/2026.
//

public enum StepStyle<Value: BinaryFloatingPoint & Sendable> {
  case native(stepSize: Value) // Notched slider track
  case stepper(stepSize: Value) // Adds explicit stepper buttons
  case none
}
