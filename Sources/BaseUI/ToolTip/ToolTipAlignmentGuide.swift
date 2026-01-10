//
//  ToolTipAlignmentGuide.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/1/2026.
//

import SwiftUI
import CoreTools

//struct ToolTipHorizontalAlignment: AlignmentID {
//  static func defaultValue(in context: ViewDimensions) -> CGFloat {
////    switch context {
////      case let thing where thing
////    }
//    
////    if context[.leading] == 0 {
////      return 50
////    } else {
////      return 0
////    }
////    return context
//    
////      dimensions[.trailing] + totalOffset(for: .horizontal)  // Place tooltip to the left
//    
////      dimensions[.leading] + totalOffset(for: .horizontal)  // Place tooltip to the right
//    
////      dimensions[HorizontalAlignment.center] + totalOffset(for: .horizontal)
//  }
//}

//extension ToolTipHorizontalAlignment {
  
//  private func setValue(for dimension)
  
  /// Note: The below `defaultOffset` bakes in a
  /// slight horizontal inset, just as it felt more pleasing.
  /// This excludes `leading` and `trailing`, where the inset
  /// would cause overlap with the content.
//  private func totalOffset(
//    for alignment: Alignment,
////    for axis: Axis2D,
//  ) -> CGFloat {
//    let excludedAlignments: [Alignment] = [.leading, .trailing]
//    let hasInset: Bool = !excludedAlignments.contains(alignment)
//    
//    let insetH: CGFloat = hasInset ? -14 : 12
//    let defaultOffset = CGSize(width: insetH, height: 10)
//    let totalOffset: CGSize = defaultOffset
//    
//    let unitPoint = toolTipAlignment.toUnitPoint()
//    
//    let finalOffset = unitPoint.offset(by: totalOffset)
//    return finalOffset.value(along: axis, mapping: .default)
//    
//  }
//}

//extension HorizontalAlignment {
//  static let toolTip = HorizontalAlignment(ToolTipHorizontalAlignment.self)
//}
//
//extension VerticalAlignment {
//  static let toolTip = VerticalAlignment(ToolTipHorizontalAlignment.self)
//}
//
//extension Alignment {
//  static let toolTip = Alignment(horizontal: .toolTip, vertical: .toolTip)
//}

//nonisolated private func guides(
//  for axis: Axis,
//  _ dimensions: ViewDimensions
//) -> CGFloat {
//  
//  switch dim
//  
//  /// Horizontal positioning
//  switch toolTipAlignment.horizontal {
//    case .leading:
//      dimensions[.trailing] + totalOffset(for: .horizontal)  // Place tooltip to the left
//    case .trailing:
//      dimensions[.leading] + totalOffset(for: .horizontal)  // Place tooltip to the right
//    default:  // center
//      dimensions[HorizontalAlignment.center] + totalOffset(for: .horizontal)
//  }
//}
