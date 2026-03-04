//
//  LineConfig+Codable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

import Foundation
//import Yams

//extension ActionLine.Configuration {
//
//  public init(yaml string: String) throws {
//    self = try YAMLDecoder().decode(ActionLine.Configuration.self, from: string)
//  }
//  public func toYAML() throws -> String {
//    try YAMLEncoder().encode(self)
//  }
//  public init(yaml data: Data) throws {
//    let string = String(decoding: data, as: UTF8.self)
//    self = try YAMLDecoder().decode(ActionLine.Configuration.self, from: string)
//  }
//  public func yamlData() throws -> Data {
//    try YAMLEncoder().encode(self).data(using: .utf8) ?? Data()
//  }
//}

  //  public init(from decoder: Decoder) throws {
  //    let container = try decoder.container(keyedBy: CodingKeys.self)
  //    density = try container.decode(Double.self, forKey: .density)
  //    radialCoverage = try container.decode(Double.self, forKey: .radialCoverage)
  //    lineStyle = try container.decode(LineStyle.self, forKey: .lineStyle)
  //    outerShape = try container.decode(BoundaryStyle.self, forKey: .outerShape)
  //    innerShape = try container.decode(BoundaryStyle.self, forKey: .innerShape)
  //    if let rotationValue = try container.decodeIfPresent(Double.self, forKey: .rotation) {
  //      _rotation = (rotationValue * 2 * .pi).truncatingRemainder(dividingBy: 2 * .pi)
  //    } else {
  //      _rotation = 0.0
  //    }
  //    shaderA = .chromaticSubtle
  //  }
  //
  //  public func encode(to encoder: Encoder) throws {
  //    var container = encoder.container(keyedBy: CodingKeys.self)
  //    try container.encode(density, forKey: .density)
  //    try container.encode(radialCoverage, forKey: .radialCoverage)
  //    try container.encode(lineStyle, forKey: .lineStyle)
  //    try container.encode(outerShape, forKey: .outerShape)
  //    try container.encode(innerShape, forKey: .innerShape)
  //    try container.encode(rotation, forKey: .rotation)
  //  }
//}
