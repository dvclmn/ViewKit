//
//  Wave+Codable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/1/2026.
//

import Foundation

extension Wave: Codable {
  
  private enum CodingKeys: String, CodingKey {
    case id
    case frequencySmoothed
    case amplitudeSmoothed
    case phaseOffsetSmoothed
    case noiseSmoothed
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(frequencySmoothed.displayed, forKey: .frequencySmoothed)
    try container.encode(amplitudeSmoothed.displayed, forKey: .amplitudeSmoothed)
    try container.encode(phaseOffsetSmoothed.displayed, forKey: .phaseOffsetSmoothed)
    try container.encode(noiseSmoothed.displayed, forKey: .noiseSmoothed)
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(UUID.self, forKey: .id)
    
    let f = try container.decode(CGFloat.self, forKey: .frequencySmoothed)
    let a = try container.decode(CGFloat.self, forKey: .amplitudeSmoothed)
    let p = try container.decode(CGFloat.self, forKey: .phaseOffsetSmoothed)
    let n = try container.decode(CGFloat.self, forKey: .noiseSmoothed)
    
    /// Rehydrate SmoothedProperty from a single scalar.
    self.frequencySmoothed = SmoothedProperty(f)
    self.amplitudeSmoothed = SmoothedProperty(a)
    self.phaseOffsetSmoothed = SmoothedProperty(p)
    self.noiseSmoothed = SmoothedProperty(n)
  }
}
