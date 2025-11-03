//
//  Box+Component.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/11/2025.
//

import Foundation

extension Box {
  public protocol Component {
//    func makeLines() -> [Box.Line]
    func makeLines(using engine: Box.Engine) -> [Box.Line]
  }
}
