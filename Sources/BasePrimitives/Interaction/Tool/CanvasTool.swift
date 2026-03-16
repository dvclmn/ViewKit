//
//  CanvasTool.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/3/2026.
//

import SwiftUI

//public protocol CanvasElement: Identifiable {
//  associatedtype ID
//}
//

/// 1. Define what a Tool can actually output.
public enum CanvasIntent {
  case mutateTransform(TransformState)
  case updateHoverLocation(CGPoint)
  //  case updateSelection([(any CanvasElement).ID])
  //  case updateHoverStatus((any CanvasElement).ID?)
  case none
}

public protocol CanvasTool {
  func resolve(
    interaction: Interaction,
    currentTransform: TransformState
  ) -> CanvasIntent
}

public struct SelectTool: CanvasTool {
  public func resolve(
    interaction: Interaction,
    currentTransform: TransformState
  ) -> CanvasIntent {
    switch interaction.kind {
      case .hovering(let location):
        /// 1. Convert viewport coordinate to document coordinate using currentTransform
        /// 2. Hit-test the document to find what is under the cursor
        /// 3. Return the intent
        //        let hitItemID = hitTest(location: location)
        //        return .updateHoverStatus(hitItemID)
        return .updateHoverLocation(location)
        
      case .scrolling(let origin, let delta, let location):
        
        /// Select Tool allows standard panning
        var newTransform = currentTransform
        newTransform.translation.width += delta.width
        return .mutateTransform(newTransform)
        
      default:
        return .none
    }
  }
}


/// A canvas tool's identity and visual metadata.
///
/// Keyboard shortcuts are intentionally *not* stored here — they belong
/// in `ToolBinding`, which is the single source of truth for input mapping.
/// This keeps `CanvasTool` focused on "what is this tool?" rather than
/// "how do I activate it?".
//public struct CanvasTool: Sendable, Identifiable, Hashable {
//  public let kind: CanvasToolKind
//  public var id: CanvasToolKind { kind }
//
//  public let name: String
//  public let icon: String
////  public let dragBehavior: DragBehavior
//
//  public init(
//    kind: CanvasToolKind,
//    name: String,
//    icon: String,
////    dragBehavior: DragBehavior = .none
//  ) {
//    self.kind = kind
//    self.name = name
//    self.icon = icon
////    self.dragBehavior = dragBehavior
//  }
//}

