//
//  Untitled.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/10/2025.
//

import Foundation
import GridKit

public enum GridFillStyle {
  case fixed(columns: Int, rows: Int)
  case fill(size: CGSize)
  
  public func size(with unitSize: CGSize) -> GridSize? {
    switch self {
      case .fixed(let columns, let rows):
        GridSize(width: columns, height: rows, unitSize: unitSize)
        
      case .fill(let size):
        GridSize(fromSize: size, unitSize: unitSize)
    }
  }
}
