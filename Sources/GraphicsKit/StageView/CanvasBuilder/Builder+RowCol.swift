//
//  Builder+RowCol.swift
//  BaseDemos
//
//  Created by Dave Coleman on 3/2/2026.
//

import SwiftUI

private enum CellAction {
  case drew
  case skip  // aka continue
  case stop  // aka break
}

extension CheckerBoardBuilder {
  package func rowColumnLoop(draw: (Path, Color) -> Void) {

    let (primaryColour, secondaryColour) = colours

    for row in rows {
      var consecutiveInvisible = 0

      for col in cols {

        switch processCell(
          col,
          row,
          consecutiveInvisible: &consecutiveInvisible,
          primaryColour: primaryColour,
          secondaryColour: secondaryColour,
          draw: draw
        ) {
          case .drew: continue
          case .skip: continue
          case .stop: break
        }
      }  // END cols
    }  // END rows loop
  }  // END loop method

  private func processCell(
    _ col: Int,
    _ row: Int,
    consecutiveInvisible: inout Int,
    primaryColour: Color,
    secondaryColour: Color,
    draw: (Path, Color) -> Void
  ) -> CellAction {

    let x = CGFloat(col) * cellSize + offsetX
    let y = CGFloat(row) * cellSize + offsetY

    let corners = [
      CGPoint(x: x, y: y),
      CGPoint(x: x + cellSize, y: y),
      CGPoint(x: x + cellSize, y: y + cellSize),
      CGPoint(x: x, y: y + cellSize),
    ]

    let transformedCorners = corners.map(distort)

    let isVisible = isQuadVisible(corners: transformedCorners)

    /// Skip invisible items (but track consecutive invisible items behind the camera)
    guard isVisible else {
      if let perspectiveStrength, perspectiveStrength < 0 {
        consecutiveInvisible += 1
        if consecutiveInvisible >= invisibleThreshold {
          return .stop  // ask the outer loop to break
        }
      }
      return .skip  // ask the outer loop to continue
    }

    /// visible path — reset and draw
    consecutiveInvisible = 0

    let path = Path { p in
      p.move(to: transformedCorners[0])
      for i in 1..<transformedCorners.count {
        p.addLine(to: transformedCorners[i])
      }
      p.closeSubpath()
    }

    let isPrimary = (col + row) & 1 == 0
    var colour = isPrimary ? primaryColour : secondaryColour

    if debugEnabled {
      if isNearCull(transformedCorners: transformedCorners) {
        colour = .orange.opacity(0.6)
      } else if isNearScreenEdge(corners: transformedCorners) {
        colour = .blue.opacity(0.25)
      }
    }

    draw(path, colour)
    return .drew
  }

}
