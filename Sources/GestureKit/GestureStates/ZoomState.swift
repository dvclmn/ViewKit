//
//  ZoomState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import CoreTools
import Foundation

public struct ZoomState: Sendable {
  public let value: CGFloat

  public static let initial: Self = .init()

  public init(
    zoom: CGFloat = 1.0,
  ) {
    self.value = zoom
  }
}

extension ZoomState {

  var zoom: CGFloat { value }

  func clamped(in range: ClosedRange<CGFloat>) -> ZoomState {
    ZoomState(zoom: zoom.clamped(to: range))
  }

  public var percentage: CGFloat { zoom * 100 }

  //  public func withPhase(_ newPhase: Interaction.Phase) -> Self {
  //    Self(zoom: value, phase: newPhase)
  //  }

  public func artworkSizeInView(_ artwork: CGSize) -> CGSize { artwork * zoom }
  public func viewSizeInArtwork(_ viewport: CGSize) -> CGSize { viewport / zoom }

}
