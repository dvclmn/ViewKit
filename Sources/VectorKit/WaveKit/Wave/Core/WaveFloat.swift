//
//  WaveFloat.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/2/2026.
//

import Foundation

public protocol WaveFloat: BinaryFloatingPoint, Sendable, Codable {}
extension Float: WaveFloat {}
extension CGFloat: WaveFloat {}
extension Double: WaveFloat {}
