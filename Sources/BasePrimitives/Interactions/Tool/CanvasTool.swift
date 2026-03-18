//
//  CanvasTool.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/3/2026.
//

import SwiftUI

/// A canvas tool defines how pointer interactions (tap, drag) are interpreted.
///
/// Global gestures (swipe→pan, pinch→zoom, hover) are handled centrally
/// by `CanvasInteractionState` and never reach `resolve()`. Tools only
/// receive pointer events: taps and drags.
///
/// Each tool declares:
/// - `kind`: Its identity, used for binding lookups and registry
/// - `name` / `icon`: Display metadata for toolbar UI
/// - `inputPolicy`: What input modes are active when this tool is selected
/// - `resolve()`: Maps a pointer interaction to a canvas intent + domain action
public protocol CanvasTool: Sendable {

  /// The tool's identity, used for keyboard binding lookups and registry.
  var kind: CanvasToolKind { get }

  /// Display name for toolbar UI.
  var name: String { get }

  /// SF Symbol name for toolbar UI.
  var icon: String { get }

  /// The input policy active when this tool is selected.
  /// Controls drag behaviour, pointer-drag-pan, etc.
  var inputPolicy: CanvasInputPolicy { get }

  /// Resolve a pointer interaction into a canvas intent and optional domain action.
  ///
  /// Only called for pointer events (`.pointerTapGesture`, `.pointerDragGesture`).
  /// Global gestures are handled before this is reached.
  func resolve(
    interaction: Interaction,
    currentTransform: TransformState
  ) -> ToolResolution
}

// MARK: - Default implementations

extension CanvasTool {
  /// Default policy: gestures enabled, no drag, hover on.
  public var inputPolicy: CanvasInputPolicy { .standard }
}

// MARK: - Default tool accessor

extension CanvasTool where Self == SelectTool {
  public static var `default`: any CanvasTool { SelectTool() }
}

// MARK: - Select Tool

/// The default selection tool. Pointer drag produces a marquee rectangle;
/// taps register tap locations.
public struct SelectTool: CanvasTool {
  public let kind: CanvasToolKind = .select
  public let name = "Select"
  public let icon = "cursorarrow"

  public var inputPolicy: CanvasInputPolicy {
    .init(dragBehaviour: .marquee)
  }

  public init() {}

  public func resolve(
    interaction: Interaction,
    currentTransform: TransformState
  ) -> ToolResolution {
    switch interaction.source {
      case .pointerTapGesture(_, let location):
        return .intent(.updatePointerTap(location))

      case .pointerDragGesture(let from, let current):
        let rect = Rect<ScreenSpace>(from: from, to: current)
        return .intent(.updatePointerDrag(rect))

      default:
        return .none
    }
  }
}

// MARK: - Pan Tool

/// When selected, pointer click-drag pans the canvas.
public struct PanTool: CanvasTool {
  public let kind: CanvasToolKind = .pan
  public let name = "Pan"
  public let icon = "hand.raised"

  public var inputPolicy: CanvasInputPolicy {
    .init(pointerDragPanEnabled: true, dragBehaviour: .continuous)
  }

  public init() {}

  public func resolve(
    interaction: Interaction,
    currentTransform: TransformState
  ) -> ToolResolution {
    switch interaction.source {
      case .pointerDragGesture(let from, let current):
        let delta = current - from
        var new = currentTransform
        new.translation += delta
        return .intent(.mutateTransform(new))

      default:
        return .none
    }
  }
}

// MARK: - Zoom Tool

/// When selected, pointer click-drag zooms (vertical axis).
/// Tap to zoom in, Option+tap to zoom out.
public struct ZoomTool: CanvasTool {
  public let kind: CanvasToolKind = .zoom
  public let name = "Zoom"
  public let icon = "magnifyingglass"

  public var inputPolicy: CanvasInputPolicy {
    .init(dragBehaviour: .continuous(axes: .vertical))
  }

  public init() {}

  public func resolve(
    interaction: Interaction,
    currentTransform: TransformState
  ) -> ToolResolution {
    switch interaction.source {
      case .pointerDragGesture(let from, let current):
        let verticalDelta = current.cgPoint.y - from.cgPoint.y
        let zoomFactor = 1.0 + (verticalDelta / 200.0)
        var new = currentTransform
        new.scale *= zoomFactor
        return .intent(.mutateTransform(new))

      case .pointerTapGesture(_, _):
        let step: CGFloat = interaction.modifiers.contains(.option) ? 0.8 : 1.25
        var new = currentTransform
        new.scale *= step
        return .intent(.mutateTransform(new))

      default:
        return .none
    }
  }
}

// MARK: - Standard tool set

extension Array where Element == any CanvasTool {
  public static var defaultTools: Self {
    [SelectTool(), PanTool(), ZoomTool()]
  }
}
