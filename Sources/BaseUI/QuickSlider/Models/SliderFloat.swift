//
//  SliderFloat.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/2/2026.
//

import Foundation

public protocol SliderFloat: BinaryFloatingPoint, Sendable {}

extension Double: SliderFloat {}
extension CGFloat: SliderFloat {}
extension Float: SliderFloat {}
