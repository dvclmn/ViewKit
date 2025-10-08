//
//  ItemBackgroundModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 25/5/2025.
//

// import BaseHelpers
import SwiftUI

//public struct ItemBackgroundModifier: ViewModifier {
////public struct ItemBackgroundModifier<Item: FuzzySearchable>: ViewModifier {
//  @Environment(\.layoutMode) private var layoutMode
//
//  /// This hopefully can be a stand-in for what was `isCurrentTool`,
//  /// when this was part of TinyTools
//  @Environment(\.isEmphasised) private var isEmphasised
//
//  private let selectedColour = Color.white.opacity(0.06)
//
////  let item: Item
////  let listPosition: ListPosition?
//  let isHovering: Bool
//
//  public func body(content: Content) -> some View {
//    content
//
//      .background {
//        switch layoutMode {
//          case .grid:
//            RoundedRectangle(cornerRadius: Styles.sizeSmall)
//              .fill(
//                isEmphasised.conditionalColour(
//                  isTrue: AnyShapeStyle(selectedColour), otherwise: AnyShapeStyle(nonSelectedColour))
//              )
//              //              .fill( emphasis == .selected ? selectedColour : nonSelectedColour)
//              .stroke(
//                LinearGradient.lightFalloff(
//                  Color.white.opacity(backgroundStrokeOpacity)), lineWidth: 1
//              )
//
//          case .list:
//            fatalError("Not currently implemented")
////            UnevenRoundedRectangle(
////              topLeadingRadius: rounding.topLeading,
////              bottomLeadingRadius: rounding.bottomLeading,
////              bottomTrailingRadius: rounding.bottomTrailing,
////              topTrailingRadius: rounding.topTrailing,
////            )
////            .fill(Color.black.opacity(0.3))
////
////            RoundedRectangle(cornerRadius: Styles.sizeSmall)
////              .fill(
////                isEmphasised.conditionalColour(isTrue: AnyShapeStyle(selectedColour), otherwise: AnyShapeStyle(.clear)))
//        //              .strokeBorder(Color.gray.opacity(store.isArrowKeySelected(item) ? 0.8 : 0), style: .simple02)
//        }  // END switch
//
//      }  // END background
//
//  }
//}
//extension ItemBackgroundModifier {
//
//  var nonSelectedColour: Color {
//    return Color.black.opacity(isHovering ? 0.45 : 0.3)
//  }
//  var backgroundStrokeOpacity: CGFloat {
//    if isEmphasised {
//      return 0.11
//    } else if isHovering {
//      return 0.09
//    } else {
//      return 0.06
//    }
//  }
//
////  var rounding: RectangleCornerRadii {
////    guard let listPosition else {
////      return RectangleCornerRadii(topLeading: .zero, bottomLeading: .zero, bottomTrailing: .zero, topTrailing: .zero)
////    }
////    return listPosition.rounding()
////  }
//
//}
