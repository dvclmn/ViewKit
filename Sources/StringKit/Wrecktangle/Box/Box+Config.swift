//
//  Box+Config.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

extension Box {
  public struct Config: Codable, Sendable {
    let width: Int
    let height: Int?
    let theme: Theme
    let metrics: Metrics
    
    public init(
      w: Int,
      h: Int? = nil,
      theme: Theme,
      metrics: Metrics
    ) {
      self.width = w
      self.height = h
      self.theme = theme
      self.metrics = metrics
    }
  }
}
extension Box.Config {
  var hasRowNumbers: Bool { metrics.contains(.lineNumbers) }
}
