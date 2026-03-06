//
//  WaveBlendMode.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation

public enum WaveBlendMode: String, Sendable, Codable {
  case add
  case multiply
  case max
  case min
  //  case weighted([CGFloat])  // optional weights
}
