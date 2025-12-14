//
//  ShaderHandler.swift
//  Eucalypt
//
//  Created by Dave Coleman on 23/2/2024.
//

import Foundation
import SwiftUI

@available(macOS 14.0, *)
protocol ShaderArgumentsConvertible {
  var arguments: [Shader.Argument] { get }
}

@available(macOS 14.0, *)
extension ShaderArgumentsConvertible {
  static func makeArguments(_ values: Any...) -> [Shader.Argument] {
    values.map { value in
      switch value {
        case let v as CGFloat:
          return .float(v)

        case let v as Float:
          return .float(v)

        case let v as Double:
          return .float(v)

        case let v as CGPoint:
          return .float2(v.x, v.y)

        case let v as SIMD2<Float>:
          return .float2(v.x, v.y)

        case let v as [Float]:
          return .floatArray(v)

        case let v as Color:
          return .color(v)

        default:
          fatalError("Unsupported Shader.Argument type: \(type(of: value))")
      }
    }
  }
}

@available(macOS 14.0, *)
public struct ChromaticAberrationArgs: ShaderArgumentsConvertible {
  public var red: CGFloat
  public var blue: CGFloat
  public var strength: CGFloat

  var arguments: [Shader.Argument] {
    Self.makeArguments(red, blue, strength)
  }
}

@available(macOS 14.0, *)
public struct GlitterArgs: ShaderArgumentsConvertible {
  public var origin: CGPoint
  public var spread: CGFloat

  var arguments: [Shader.Argument] {
    Self.makeArguments(origin, spread)
  }
}

@available(macOS 14.0, *)
public struct FisheyeArgs: ShaderArgumentsConvertible {
  public var size: CGFloat
  public var strength: CGFloat
  
  var arguments: [Shader.Argument] {
    Self.makeArguments(size, strength)
  }
}


//struct Glitter: ViewModifier {
//  private let startDate = Date()
//  @State private var oscillatingValue: CGFloat = -1.0
//
//  func body(content: Content) -> some View {
//    content
//      .overlay {
//        VStack {
//          ZStack {
//            Color.blue
//            TimelineView(.animation) { _ in
//              //                            Image(.rgbaNoise)
//              //                                .resizable(resizingMode: .tile)
//              //                                .rotation3DEffect(.degrees(20 * oscillatingValue), axis: (x: 6 * oscillatingValue, y: 4 * oscillatingValue, z: 0))
//              //        //                        .frame(width: 400, height: 600)
//              //                                .scaledToFill()
//              //                                .scaleEffect(3)
//              //                                .offset(x: 10 * oscillatingValue, y: 14 * oscillatingValue)
//              //                                .visualEffect { content, geo in
//              //                                    content
//              //                                        .layerEffect(ShaderLibrary.glitterTest(
//              //                                            .float2(geo.size),
//              //                                            .float(startDate.timeIntervalSinceNow)), maxSampleOffset: .zero)
//              //
//              //                                }
//
//            }  // END timeline
//            .blendMode(.destinationOut)
//          }
//          .compositingGroup()
//        }  // END vstack
//        .blur(radius: 1.0)
//        .blendMode(.colorDodge)
//        .opacity(0.2)
//
//      }  // END overlay
//      .onAppear {
//        withAnimation(.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
//          oscillatingValue = 1.0
//        }
//      }  // END on appear
//
//    //                        .overlay {
//    //                            VStack {
//    //                                LinearGradient(stops: [
//    //                                    .init(color: .clear, location: 0),
//    //                                    .init(color: .white, location: 0.4),
//    //                                    .init(color: .clear, location: 0.45),
//    //                                    .init(color: .white, location: 0.75),
//    //                                    .init(color: .clear, location: 1.0)
//    //                                ], startPoint: .leading, endPoint: .trailing)
//    //                            }
//    //                            .frame(width: 700, height: 6000)
//    //                            .rotationEffect(.degrees(45))
//    //                            .offset(x: 800 * whipAnimation)
//    //                            .blendMode(.overlay)
//    //                            .opacity(0.1)
//    //                        }
//    //
//    //
//    //
//    //
//    //
//
//  }
//}
//
//extension View {
//  public func glitter() -> some View {
//    modifier(Glitter())
//  }
//}
//
