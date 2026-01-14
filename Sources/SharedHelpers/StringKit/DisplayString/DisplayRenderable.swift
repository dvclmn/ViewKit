//
//  DisplayRenderable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/1/2026.
//

public protocol DisplayRenderable: Sendable {
  func render(using format: DisplayFormat) -> String
}
