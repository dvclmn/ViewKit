//
//  CanvasTool.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/3/2026.
//

import SwiftUI

public protocol CanvasTool: Sendable {
  
  var inputPolicy: CanvasInputPolicy { get }
   
  /// This allows a Tool to declare what should happen when it is selected,
  /// and certain interaction events happen
  ///
  /// Note: this was previously handled by now-retired types like `CanvasOperation`
  /// and `CanvasOperation.Kind`. Now, mapping interaction to intent is owned here
  func resolve(
    interaction: Interaction,
    currentTransform: TransformState
  ) -> CanvasIntent
}

extension CanvasTool where Self == SelectTool {
  public static var `default`: any CanvasTool { SelectTool() }
}

public struct SelectTool: CanvasTool {
  public func resolve(
    interaction: Interaction,
    currentTransform: TransformState
  ) -> CanvasIntent {
    switch interaction.source {
      case .swipeGesture(let delta, let location):
        return .defaultPan(
          delta: delta,
          location: location,
          transform: currentTransform
        )

      case .pinchGesture(let event):
        return .defaultZoom(
          event: event,
          transform: currentTransform
        )

      case .continuousHover(let point):
        return .updateHoverLocation(point)

      case .pointerTapGesture(let pointerButton, let location):
        return .none

      case .pointerDragGesture(let from, let current):
        return .none
    }
    //      case .hovering(let location):
    //        /// 1. Convert viewport coordinate to document coordinate using currentTransform
    //        /// 2. Hit-test the document to find what is under the cursor
    //        /// 3. Return the intent
    //        //        let hitItemID = hitTest(location: location)
    //        //        return .updateHoverStatus(hitItemID)
    //        return .updateHoverLocation(location)
    //
    //      case .swiping(let delta, let location):
    //
    //        /// Select Tool allows standard panning
    //        var new = currentTransform
    //        new.translation += delta
    //        return .mutateTransform(new)
    //
    //      default:
    //        return .none
    //    }
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
