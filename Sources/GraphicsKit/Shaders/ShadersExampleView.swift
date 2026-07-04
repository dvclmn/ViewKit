//
//  ShadersExampleView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 17/5/2025.
//

import CoreTools
import ViewTools
// import BaseTools
import SwiftUI


public struct ShadersExampleView: View {

  public var body: some View {

    GeometryReader { proxy in
      ZStack {
        StageView(floorConfig: .init(), viewSize: proxy.size)
          .overlay {
            Color.purple.opacity(0.08)
            Color.black.opacity(0.2)
          }

        ForEach(EmojiBunch.allCases) { emoji in
          Text(emoji.emojiString)
            .font(.system(size: 140))
            //          FeatureIconView(
            //            emoji: emoji.emojiString,
            //            fontSize: 140
            //          )
            .offset(emoji.offset(in: proxy.size, strength: 0.4))
        }

      }
    }
    .compositingGroup()
//    .shaderEffect(
//      .chromaticAberration(
//        r: 0.9,
//        b: 0.8,
//        strength: 0.5,
//        radialStrength: ,
//        center:
//      )
//    )
//    .shaderEffect(.chromaticAberration(.init(red: 0.9, blue: 0.8, strength: 0.5)))
    //    .layerEffect(
    //      ShaderLibrary.bundle(.module).chromaticAberration(
    //        .float(70),
    //        .float(1.0),
    //        .float(1.0),
    //      ),
    //      maxSampleOffset: .zero
    //    )
    //    .layerEffect(
    //      ShaderLibrary.bundle(.module).ripple(
    //        .float2(10, 6),
    //        .float2(1.0, 10),
    //      ),
    //      maxSampleOffset: .zero
    //    )
    //    .layerEffect(ShaderLibrary.ripple(.float2(30, 70), .float2(100, 200)), maxSampleOffset: .zero)
    //    .shaderEffect(
    //      .chromaticAberration,
    //      [
    //        .float(0.9),
    //        .float(1.9),
    //        .float(0.5),
    //      ]
    //    )

    .frame(width: 600, height: 700)

  }
}
#if DEBUG

#Preview {
  ShadersExampleView()
}
#endif

enum EmojiBunch: String, CaseIterable, Identifiable {
  case burger
  case rollerSkates
  case devil
  case coconut
  case pear
  case dimaond

  var id: String { rawValue }

  var emojiString: String {
    switch self {
      case .burger: "🍔"
      case .rollerSkates: "🛼"
      case .devil: "👺"
      case .coconut: "🥥"
      case .pear: "🍐"
      case .dimaond: "💎"
    }
  }

  private var direction: UnitPoint {
    switch self {
      case .burger: .topLeading
      case .rollerSkates: .trailing
      case .devil: .topTrailing
      case .coconut: .bottom
      case .pear: .bottomLeading
      case .dimaond: .center
    }
  }
  private var offsetX: CGFloat {
    switch self {
      case .burger: 0.7
      case .rollerSkates: 0.9
      case .devil: 0.5
      case .coconut: 0.1
      case .pear: 0.8
      case .dimaond: 0.0
    }
  }

  private var offsetY: CGFloat {
    switch self {
      case .burger: 0.45
      case .rollerSkates: 0.5
      case .devil: 0.7
      case .coconut: 0.6
      case .pear: 0.5
      case .dimaond: 0.0
    }
  }
  func offset(
    in containerSize: CGSize,
    strength strengthFactor: CGFloat
  ) -> CGSize {
    let x = (offsetX * -1) * containerSize.width.halved * strengthFactor
    let y = (offsetY * -1) * containerSize.height.halved * strengthFactor
    return direction.offset(dx: x, dy: y)
  }

}
