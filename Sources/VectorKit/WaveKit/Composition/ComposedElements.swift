//
//  ComposedElements.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/2/2026.
//

import Foundation

public struct ComposedElements: Codable, Sendable, Equatable {
  public var waveComposition: WaveComposition
  
  /// The channels define which elements are driven by which waves (and how).
  public var channels: [WaveChannel]
  
  /// Author-time elements (for the *sample*). You can treat these as defaults/prototypes.
  /// Why prototypes and not [WaveVisualElement]?
  /// Because your per-sample dotY base etc changes with index (baseY), and you don’t want to
  /// persist 200 elements for every sample unless you really mean to. Store defaults,
  /// then build per-sample elements cheaply.
  public var elementPrototypes: [WaveVisualElement.ElementKind: Double]
  
  public init(
    waveComposition: WaveComposition,
    channels: [WaveChannel],
    elementPrototypes: [WaveVisualElement.ElementKind: Double]
  ) {
    self.waveComposition = waveComposition
    self.channels = channels
    self.elementPrototypes = elementPrototypes
  }
}

extension ComposedElements {
  public static func original(
    waveH: ConfiguredWave,
    waveV: ConfiguredWave,
    waveR: ConfiguredWave,
    style: WaveStyle,
    sampleCount: Int,
    interpolation: WaveInterpolation
  ) -> Self {
    let composition = WaveComposition(
      waves: [waveH, waveV, waveR],
      style: style,
      blendMode: .add,           // whatever your enum is
      placement: .vertical, // placeholder
      sampleCount: sampleCount,
      interpolation: interpolation
    )
    
    let channels: [WaveChannel] = [
      .dotX(with: waveV),              // vertical wave affects X (as you had)
      .dotY(with: waveH),              // horizontal wave affects Y (as you had)
      .dotRadius(with: waveR),
      // .dashPhase(with: waveV),       // optional
    ]
    
    let prototypes: [WaveVisualElement.ElementKind: Double] = [
      .dotRadius: style.pointStyle.radius,
      .dashPhase: style.lineStyle.dashPhase,
      .lineWidth: style.lineStyle.lineWidth,
    ]
    
    return .init(
      waveComposition: composition,
      channels: channels,
      elementPrototypes: prototypes
    )
  }
}

/// Ha need to fix these naaaames
//public struct ComposedElements: Codable, Sendable, Equatable {
//  public var waveComposition: WaveComposition
//  public var elements: [WaveVisualElement]
//  //  public var elements: ElementStore
//
//  public init(
//    waveComposition: WaveComposition,
//    elements: [WaveVisualElement]
//      //    elements: ElementStore
//  ) {
//    self.waveComposition = waveComposition
//    self.elements = elements
//  }
//}
//
//extension ComposedElements {
//  public func thing() {
//    let channels: [WaveChannel] = [
//      .dotHorizontal(with: <#T##ConfiguredWave#>)
//    ]
//  }
//}

/// Let's set up some initial elements just to play
//extension ComposedElements {
//  public static let example: ComposedElements = .init(
//    waveComposition: .example,
//    elements: [
//      WaveVisualElement(
//        kind: .dotRadius,
//        initialValue: 2.0,
//      ),
//      WaveVisualElement(kind: .dotX),
//      WaveVisualElement(kind: .dotY),
//    ]
//  )
//
//}
