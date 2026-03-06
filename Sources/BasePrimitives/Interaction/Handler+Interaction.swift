//
//  Model+InteractionRules.swift
//  BaseComponents
//
//  Created by Dave Coleman on 19/7/2025.
//

import BasePrimitives
import SwiftUI

//public struct InteractionState {
//  let value:
//  let kind: InteractionKind.Meta
//}

//public struct InteractionHandler {
//
//  public var zoom: CGFloat = 1.0
//  public var pan: CGSize = .zero
//  public var rotation: Angle = .zero
//  public var tapLocation: CGPoint?
//  public var hoverLocation: CGPoint?
//  public var dragRect: CGRect?
//  //  public var tapRanges: CGRect?
//  //  public var state: InteractionState
//  /// Important: There is a difference between handling the
//  /// current active interaction, and handling which interactions
//  /// are allowed to be initiated at any given time.
//  //  public var active: InteractionKind.Meta? = nil
//  public var active: Interaction? = nil
//  //  public var phase: InteractionPhase = .none
//
//  /// This forces the caller to define which is allowed.
//  /// If not defined, none will work.
//  public var allowed: InteractionKind.Meta
//  //  public var keysHeld: Keys = []
//  //  public var modifiersHeld: Modifiers = []
//
//  let keysToWatch: Set<KeyEquivalent> = [.space]
//
//  public init(
//    allowed: InteractionKind.Meta = .none,
//  ) {
//    self.allowed = allowed
//  }
//}

//extension InteractionHandler {
//
////  func panClamped(
////    artwork: CGSize,
////    viewport: CGSize,
////  ) -> CGSize {
////    let scaledArtwork = artwork * zoom
////
////    let maxX = max((scaledArtwork.width - viewport.width) / 2, 0)
////    let maxY = max((scaledArtwork.height - viewport.height) / 2, 0)
////
////    return CGSize(
////      width: pan.width.clamped(to: -maxX...maxX),
////      height: pan.height.clamped(to: -maxY...maxY)
////    )
////  }
//
//  public var zoomPercentage: CGFloat { zoom * 100 }
//  func zoomClamped(in range: ClosedRange<CGFloat>) -> CGFloat {
//    zoom.clamped(to: range)
//  }
//
////  func panTranslated(by delta: CGSize) -> CGSize {
////    CGSize(
////      width: self.pan.width - delta.width,
////      height: self.pan.height - delta.height
////    )
////
////  }
//
//  var viewOffset: CGSize { pan * zoom }
//  var artworkOffset: CGSize { pan / zoom }
//
//  public func artworkSizeInView(_ artwork: CGSize) -> CGSize { artwork * zoom }
//  public func viewSizeInArtwork(_ viewport: CGSize) -> CGSize { viewport / zoom }
//
//  public func isAllowed(_ kind: InteractionKind.Meta) -> Bool {
//    self.allowed == kind
//  }

//  public mutating func updateGesture(
//    _ kind: InteractionKind,
//    phase: InteractionPhase,
//    modifiers: Modifiers?
//      //    viewportSize: CGSize,
//      //    canvasSize: CGSize,
//      //    geometry: CanvasGeometry
//  ) {
//
//    let newActive = Interaction(
//      kind: InteractionKind.Meta(kind),
//      phase: phase,
//      modifiers: modifiers
//    )
//    self.active = newActive
//
//    switch kind {
//      case .tap(let value):
//        self.tapLocation = value
//
//      case .drag(let value):
//        self.dragRect = value
//
//      case .tapRanges, .longPress:
//        print("Not yet supported")
//        break
//
//      case .gestureZoom(let value):
//        self.zoom = value
//
//      case .gesturePan(let value):
//        self.pan = value
//
//      case .gestureRotate(let value):
//        self.rotation = value
//
//      case .hover(let value):
//        self.hoverLocation = value
//
//      case .none:
//        break
//
//    }

    //    self.phase = phase

    //    switch kind {
    //      case .gesturePan(let value):
    //        pan = pan.translated(by: value)
    //
    //      //          .withPhase(state.phase)
    //
    //      case .gestureZoom(let value):
    //        /// Will need to save this in case I somehow route the
    //        /// zoom action kind that I want
    //        //        let newZoom: CGFloat = value.resolve(
    //        //          //          current: zoom,
    //        //          artwork: geometry.canvasSize,
    //        //          viewport: geometry.viewportSize
    //        //        )
    //        zoom = ZoomState(zoom: value)
    //
    //      case .gestureRotate(let value):
    //        rotate = RotateState(rotation: value)
    //
    //      default:
    //        assertionFailure("Only handling *gesture* interaction types here")
    //        //        print("")
    //        break
    //    //      default: break
    //    }

    /// Update current interaction
    //    updateIfChanged(&interactions.interaction, to: kind.interactionType)
//  }

//  public mutating func reset(_ kind: InteractionKind.Meta) {
//    self.active = nil
//    switch kind {
//      case .tap: self.tapLocation = nil
//      case .drag: self.dragRect = nil
//
//      case .tapRanges, .longPress:
//        print("Not yet supported")
//        break
//
//      case .gestureZoom: self.zoom = .zero
//      case .gesturePan: self.pan = .zero
//      case .gestureRotate: self.rotation = .zero
//      case .hover: self.hoverLocation = nil
//      case .none: break
//
//    }
//    //    self.current
//    //    switch kind {
//    //      case .gesturePan: pan = .initial
//    //      case .gestureZoom: zoom = .initial
//    //      case .gestureRotate: rotate = .initial
//    //      default:
//    //        assertionFailure("Only handling *gesture* interaction types here")
//    //        break
//    //        //      default: break
//    //    }
//  }

//}
//public struct GestureContext {
//  let zoom: CGFloat
//  let pan: CGPoint
//  let rotation: Angle
//
//  public init(
//    zoom: CGFloat = 1.0,
//    pan: CGPoint = .zero,
//    rotation: Angle = .zero
//  ) {
//    self.zoom = zoom
//    self.pan = pan
//    self.rotation = rotation
//  }
//
//}
