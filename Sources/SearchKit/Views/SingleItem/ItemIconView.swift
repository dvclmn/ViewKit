//
//  ItemIconView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 25/5/2025.
//

import BaseHelpers
import BaseUI
import SwiftUI

//public struct ItemIconView: View {
//  @Environment(\.layoutMode) private var layoutMode
//  @Environment(\.isEmphasised) private var isEmphasised
//  @Environment(\.emphasisColour) private var emphasisColour
//
//  let icon: IconLiteral?
////  let label: QuickLabel
//  let isHovering: Bool
//
//  public var body: some View {
//
//    if let icon = icon?.toString {
//      Image(systemName: icon)
//        .font(.system(size: iconSize))
//        .scaleEffect(isHovering ? iconScaleEffect : 1.0)
////        .foregroundStyle(isEmphasised ? emphasisColour?.toShapeStyle : AnyShapeStyle(.primary.opacity(isHovering ? 1.0 : 0.9)))
//        .foregroundStyle(
//          isEmphasised.conditionalColour(
//            isTrue: emphasisColour,
//            otherwise: AnyShapeStyle(.primary.opacity(isHovering ? 1.0 : 0.9))
//          )
//        )
//        .frame(width: iconSize, height: iconSize)
//
//        /// Adds another animation modifier here, just for the image,
//        /// to give a 'secondary motion' feeling
//        .animation(.snappy(duration: 0.25, extraBounce: 0.25), value: isHovering)
//        .symbolVariant(.fill)
//        .symbolRenderingMode(.hierarchical)
//        .offset(y: isHovering ? -1.2 : 0)
////        .border(Color.purple.opacity(0.3))
//    }
//  }
//}
//
//extension ItemIconView {
//  var iconScaleEffect: CGFloat {
//    switch layoutMode {
//      case .grid: 1.06
//      case .list: 1.04
//    }
//  }
//  var iconSize: CGFloat {
//    switch layoutMode {
//      case .grid: 26
//      case .list: 22
//    }
//  }
//}
