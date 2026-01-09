//
//  ZoomState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import Foundation
import SharedHelpers

public struct ZoomState: GestureStateProtocol, Sendable {
  public let value: CGFloat
  public let phase: GesturePhase

  public static let initial: Self = .init()

  public init(
    zoom: CGFloat = 1.0,
    phase: GesturePhase = .none
      //    phase: ZoomPhase = .inactive,
  ) {
    self.value = zoom
    self.phase = phase
    //    self.zoomRange = range
  }
}

extension ZoomState {

  var zoom: CGFloat { value }

  func clamped(in range: ClosedRange<CGFloat>) -> ZoomState {
    ZoomState(
      zoom: zoom.clamped(to: range),
      phase: phase
    )
  }

  public var percentage: CGFloat { zoom * 100 }

  public func withPhase(_ newPhase: GesturePhase) -> Self {
    Self(zoom: value, phase: newPhase)
  }

  public func artworkSizeInView(_ artwork: CGSize) -> CGSize { artwork * zoom }
  public func viewSizeInArtwork(_ viewport: CGSize) -> CGSize { viewport / zoom }

  public static func fitScale(
    artwork: CGSize,
    viewport: CGSize
  ) -> CGFloat {
    min(
      viewport.width / artwork.width,
      viewport.height / artwork.height
    )
  }

  public static func fillScale(
    artwork: CGSize,
    viewport: CGSize
  ) -> CGFloat {
    max(
      viewport.width / artwork.width,
      viewport.height / artwork.height
    )
  }
}
