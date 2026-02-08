//
//  SliderFloat.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/2/2026.
//

import Foundation

public protocol SliderFloat: BinaryFloatingPoint, Sendable, Strideable where Stride: BinaryFloatingPoint {}

extension Double: SliderFloat {}
extension CGFloat: SliderFloat {}
extension Float: SliderFloat {}
