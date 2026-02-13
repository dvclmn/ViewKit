//
//  WaveDocument.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/2/2026.
//

import Foundation

public struct WaveDocument: Codable, Sendable, Equatable {
  
  /// composition owns waves
  public var library: WaveLibrary

  /// The channels define which elements are driven by which waves (and how).
  /// binds wave→element
  public var channels: [WaveChannel]

  /// Author-time elements (for the *sample*). You can treat these as defaults/prototypes.
  /// Prototypes define base values used to instantiate per-sample elements
  public var elementPrototypes: [WaveVisualElement.ElementKind: Double]

  public init(
    library: WaveLibrary,
    channels: [WaveChannel],
    elementPrototypes: [WaveVisualElement.ElementKind: Double]
  ) {
    self.library = library
    self.channels = channels
    self.elementPrototypes = elementPrototypes
  }
}

extension WaveDocument {
  public static func original(
    waveH: ConfiguredWave = .init(),
    waveV: ConfiguredWave = .init(),
    waveR: ConfiguredWave = .init(),
    style: WaveStyle = .init(),
    sampleCount: Int = 30,
    interpolation: WaveInterpolation = .cubic()
  ) -> Self {
    let composition = WaveLibrary(
      waves: [waveH, waveV, waveR],
      style: style,
      blendMode: .add,  // whatever your enum is
      placement: .vertical,  // placeholder
      sampleCount: sampleCount,
      interpolation: interpolation
    )

    let channels: [WaveChannel] = [
      .dotX(with: waveV),  // vertical wave affects X (as you had)
      .dotY(with: waveH),  // horizontal wave affects Y (as you had)
      .dotRadius(with: waveR),
      // .dashPhase(with: waveV),       // optional
    ]

    let prototypes: [WaveVisualElement.ElementKind: Double] = [
      .dotRadius: style.pointStyle.radius,
      .dashPhase: style.lineStyle.dashPhase,
      .lineWidth: style.lineStyle.lineWidth,
    ]

    return .init(
      library: composition,
      channels: channels,
      elementPrototypes: prototypes
    )
  }
}

/// Ha need to fix these naaaames
//public struct ComposedElements: Codable, Sendable, Equatable {
//  public var waveComposition: WaveLibrary
//  public var elements: [WaveVisualElement]
//  //  public var elements: ElementStore
//
//  public init(
//    waveComposition: WaveLibrary,
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
