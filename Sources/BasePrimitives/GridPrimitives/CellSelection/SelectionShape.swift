//
//  SelectionShape.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/3/2026.
//

public struct Selection {
  var regions: [SelectionRegion]
}

extension Selection {
  public var isDisjoint: Bool { regions.count > 1 }
}

public enum SelectionRegion {
  case rectangle(GridRect)
  case cells(Set<GridPosition>)
}
