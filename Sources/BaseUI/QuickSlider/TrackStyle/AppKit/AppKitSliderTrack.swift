//
//  AppKitSliderTrack.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/6/2026.
//

#if os(macOS)
import AppKit
import SwiftUI

public protocol AppKitSliderTrackStyle {
  func makeAppKitTrack(configuration: SliderTrackConfiguration) -> AppKitSliderTrack
}

public struct AppKitSliderTrack {
  public var layers: [Layer]
  public var stroke: ResolvedTrackColour?

  public init(
    layers: [Layer],
    stroke: ResolvedTrackColour? = .init(white: 0.0, alpha: 0.18),
  ) {
    self.layers = layers
    self.stroke = stroke
  }
}

extension AppKitSliderTrack {
  public static func linearGradient(
    _ colours: [ResolvedTrackColour],
    stroke: ResolvedTrackColour? = .init(white: 0.0, alpha: 0.18),
  ) -> Self {
    Self(
      layers: [.linearGradient(GradientStop.evenlySpaced(from: colours))],
      stroke: stroke,
    )
  }

  public static func opacityGradient(
    _ colour: ResolvedTrackColour,
    stroke: ResolvedTrackColour? = .init(white: 0.0, alpha: 0.18),
  ) -> Self {
    Self(
      layers: [
        .checkerboard(Checkerboard()),
        .linearGradient([
          GradientStop(colour: colour.withAlpha(0.0), location: 0.0),
          GradientStop(colour: colour, location: 1.0),
        ]),
      ],
      stroke: stroke,
    )
  }
}

extension AppKitSliderTrack {
  func draw(in rect: NSRect) {
    guard !rect.isEmpty else { return }

    let path = NSBezierPath(
      roundedRect: rect,
      xRadius: rect.height / 2,
      yRadius: rect.height / 2,
    )

    NSGraphicsContext.saveGraphicsState()
    path.addClip()

    for layer in layers {
      layer.draw(in: rect)
    }

    NSGraphicsContext.restoreGraphicsState()

    if let stroke {
      stroke.nsColour.setStroke()
      path.lineWidth = 1
      path.stroke()
    }
  }
}

extension AppKitSliderTrack.Layer {
  func draw(in rect: NSRect) {
    switch self {
      case .colour(let colour):
        colour.nsColour.setFill()
        rect.fill()

      case .linearGradient(let stops):
        drawLinearGradient(stops, in: rect)

      case .checkerboard(let checkerboard):
        drawCheckerboard(checkerboard, in: rect)
    }
  }

  private func drawLinearGradient(
    _ stops: [AppKitSliderTrack.GradientStop],
    in rect: NSRect,
  ) {
    guard !stops.isEmpty else { return }

    guard stops.count > 1 else {
      stops[0].colour.nsColour.setFill()
      rect.fill()
      return
    }

    guard
      let context = NSGraphicsContext.current?.cgContext,
      let colourSpace = CGColorSpace(name: CGColorSpace.sRGB),
      let gradient = CGGradient(
        colorsSpace: colourSpace,
        colors: stops.map(\.colour.cgColour) as CFArray,
        locations: stops.map(\.location),
      )
    else { return }

    context.saveGState()
    context.drawLinearGradient(
      gradient,
      start: CGPoint(x: rect.minX, y: rect.midY),
      end: CGPoint(x: rect.maxX, y: rect.midY),
      options: [],
    )
    context.restoreGState()
  }

  private func drawCheckerboard(
    _ checkerboard: AppKitSliderTrack.Checkerboard,
    in rect: NSRect,
  ) {
    let squareLength = max(checkerboard.squareLength, 1.0)
    let columns = Int(ceil(rect.width / squareLength))
    let rows = Int(ceil(rect.height / squareLength))

    for row in 0...rows {
      for column in 0...columns {
        let colour =
          (row + column).isMultiple(of: 2)
          ? checkerboard.primary
          : checkerboard.secondary

        colour.nsColour.setFill()

        NSRect(
          x: rect.minX + CGFloat(column) * squareLength,
          y: rect.minY + CGFloat(row) * squareLength,
          width: squareLength,
          height: squareLength,
        )
        .fill()
      }
    }
  }
}

#endif
