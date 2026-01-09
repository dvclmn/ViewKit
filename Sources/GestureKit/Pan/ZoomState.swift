//
//  ZoomState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import Foundation
import SharedHelpers

public struct ZoomState: Sendable {
  let zoom: CGFloat
  let phase: ZoomPhase
  let zoomRange: ClosedRange<CGFloat>

  static let initial: Self = .init()

  public init(
    zoom: CGFloat = 1.0,
    phase: ZoomPhase = .inactive,
    range: ClosedRange<CGFloat> = 0.1...8
  ) {
    self.zoom = zoom
    self.phase = phase
    self.zoomRange = range
  }
}

extension ZoomState {
  public var percentage: CGFloat { zoom * 100 }
  public var isActive: Bool { phase == .active }

  func withPhase(_ newPhase: ZoomPhase) -> Self {
    .init(zoom: zoom, phase: newPhase)
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

public enum ZoomPhase: Sendable {
  case inactive
  case active
  case ended
}
