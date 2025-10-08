//
//  ToolTipHelpers.swift
//  BaseComponents
//
//  Created by Dave Coleman on 1/10/2025.
//

// import BaseHelpers
import SwiftUI

extension Alignment {

  /// This remaps any alignments that don't quite make sense for
  /// a ToolTip, such as center (don't want it covering the content)
  var forTooltip: Alignment {
    switch self {
      case .center: .top
      default: self
    }
  }
  
  var toolTipUnitPoint: UnitPoint? {
    switch self {
      case .leading: return UnitPoint(x: 0, y: 0.5)
      case .trailing: return UnitPoint(x: 1, y: 0.5)
      case .top: return UnitPoint(x: 0.5, y: 0)
      case .bottom: return UnitPoint(x: 0.5, y: 1)
      case .topLeading: return .topLeading
      case .topTrailing: return .topTrailing
      case .bottomLeading: return .bottomLeading
      case .bottomTrailing: return .bottomTrailing
      case .center: return .center
      default: return nil // baseline cases
    }
  }
}



//extension Alignment {
////extension HorizontalAlignment {
//  /// Offset here referring to 'one dimension at a time',
//  /// hence why we return a `CGFloat` not a `CGSize`
//  func toolTipOffset(
//    dimensions: ViewDimensions,
//    baseOffset: CGFloat = 12,
//    additionalOffset: CGSize
//  ) -> CGFloat {
////    let axis: AlignmentForAxis = .horizontal(self.opposite)
//    switch self {
//      case .leading: dimensions.tooltipAdjustment(axis: axis, baseOffset: baseOffset, additionalOffset: additionalOffset)
//      case .trailing:
//      case default:
//    }
////    switch self {
////      case .leading:
////        return dimensions[.trailing] + baseOffset - offset.width  // Place tooltip to the left
////      case .trailing:
////        return dimensions[.leading] + baseOffset - offset.width  // Place tooltip to the right
////      default:  // center
////        return dimensions[HorizontalAlignment.center] + baseOffset - offset.width
////    }
//  }
//}
//
//extension ViewDimensions {
//  func tooltipAdjustment(
//    axis: AlignmentForAxis,
//    baseOffset: CGFloat = 12,
//    additionalOffset: CGSize
//  ) -> CGFloat {
//
//    switch axis {
//      case .horizontal(let alignment):
//        let offset = baseOffset + additionalOffset.width
//        return self[alignment] - offset
//
//      case .vertical(let alignment):
//        let offset = baseOffset + additionalOffset.height
//        return self[alignment] - offset
//    }
//  }
//}
