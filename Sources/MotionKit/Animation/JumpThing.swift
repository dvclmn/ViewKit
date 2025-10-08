//
//  JumpThing.swift
//  BaseComponents
//
//  Created by Dave Coleman on 15/8/2025.
//

//import SwiftUI
// import BaseHelpers

//public struct JumpAnimationModifier: ViewModifier {
//  
//  @State private var tapCount = 1
//  
//  public init() {}
//  
//  public func body(content: Content) -> some View {
//    content
//      .rotationEffect(.degrees(value(EffectKey.Rotation.degrees)))
//      .offset(x: value(EffectKey.Offset.horizontal), y: value(EffectKey.Offset.vertical))
//    //            .offset(x: store.emoji.displayPosition.x, y: store.emoji.displayPosition.y)
//      .hueRotation(.degrees(value(EffectKey.Hue.degrees)))
//      .blur(radius: value(EffectKey.Blur.strength))
//      .opacity(value(EffectKey.Opacity.strength))
//      .brightness(value(EffectKey.Brightness.strength))
//      .keyframeAnimator(
//        initialValue: OtherValues(),
//        //                              repeating: true
//        trigger: tapCount
//      ) { content, value in
//        content
//          .opacity(value.opacity)
//          .brightness(value.brightness)
//          .rotationEffect(value.angle)
//          .scaleEffect(value.scale)
//          .scaleEffect(y: value.verticalStretch)
//          .offset(y: value.verticalOffset)
//          .offset(x: value.horizontalOffset)
//          .blur(radius: value.blur)
//          .background {
//            Color.red
//              .opacity(value.redFlash)
//          }
//      } keyframes: { _ in
//        
//        KeyframeTrack(\.verticalOffset) {
//          LinearKeyframe(0.0, duration: 0.05)
//          CubicKeyframe(-210, duration: 0.2)
//          CubicKeyframe(-214, duration: 0.85)
//          CubicKeyframe(0.0, duration: 0.3)
//        }
//        
//        KeyframeTrack(\.horizontalOffset) {
//          
//          LinearKeyframe(0.0, duration: 0.05)
//          CubicKeyframe(-46, duration: 0.3)
//          //                  CubicKeyframe(-80, duration: 0.9)
//          //                  CubicKeyframe(-120, duration: 0.5)
//          CubicKeyframe(-140, duration: 1.2)
//          
//        }
//        
//        KeyframeTrack(\.verticalStretch) {
//          
//          LinearKeyframe(1.0, duration: 0.1)
//          CubicKeyframe(1.4, duration: 0.1)
//          CubicKeyframe(1.0, duration: 0.4)
//          
//          //                  CubicKeyframe(-80, duration: 0.9)
//          //                  CubicKeyframe(-120, duration: 0.5)
//          CubicKeyframe(1.0, duration: 0.6)
//          CubicKeyframe(1.4, duration: 0.1)
//          CubicKeyframe(1.0, duration: 0.1)
//          
//        }
//        
//        KeyframeTrack(\.scale) {
//          CubicKeyframe(1.0, duration: 0.05)
//          CubicKeyframe(0.6, duration: 0.3)
//          CubicKeyframe(0.3, duration: 1.1)
//          CubicKeyframe(0.2, duration: 0.9)
//          CubicKeyframe(0.18, duration: 0.4)
//          
//          //                  CubicKeyframe(0.0, duration: 0.3)
//        }
//        
//        KeyframeTrack(\.angle) {
//          
//          LinearKeyframe(.zero, duration: 0.1)
//          //                  CubicKeyframe(.degrees(-50.0), duration: 0.2)
//          LinearKeyframe(.degrees(-30.0), duration: 0.4)
//          //                  CubicKeyframe(.degrees(-50.0), duration: 0.5)
//          //                  CubicKeyframe(.degrees(-24.0), duration: 0.4)
//          
//          CubicKeyframe(.degrees(-380), duration: 0.25)
//          LinearKeyframe(.degrees(-430), duration: 0.7)
//          //                  LinearKeyframe(.degrees(-480), duration: 0.4)
//          
//        }
//        
//        KeyframeTrack(\.redFlash) {
//          //                  LinearKeyframe(0.0, duration: 0.1)
//          MoveKeyframe(1.0)
//          LinearKeyframe(0.0, duration: 0.1)
//        }
//        
//        KeyframeTrack(\.blur) {
//          
//          LinearKeyframe(0.0, duration: 0.1)
//          //                  CubicKeyframe(.degrees(-50.0), duration: 0.2)
//          LinearKeyframe(0.0, duration: 0.3)
//          LinearKeyframe(3.0, duration: 0.2)
//          //                  CubicKeyframe(.degrees(-50.0), duration: 0.5)
//          //                  CubicKeyframe(.degrees(-24.0), duration: 0.4)
//          
//          CubicKeyframe(0.4, duration: 0.2)
//          //                  LinearKeyframe(.degrees(-430), duration: 0.8)
//          
//        }
//        
//        KeyframeTrack(\.brightness) {
//          CubicKeyframe(0.0, duration: 0.1)
//          CubicKeyframe(-0.4, duration: 1.1)
//          //                  CubicKeyframe(0.0, duration: 0.3)
//        }
//        
//        KeyframeTrack(\.opacity) {
//          CubicKeyframe(1.0, duration: 0.1)
//          CubicKeyframe(0.6, duration: 1.1)
//          //                  CubicKeyframe(0.0, duration: 0.3)
//        }
//        
//      }
//      .onTapGesture {
//        tapCount += 1
//      }
//  }
//}
//extension JumpAnimationModifier {
//  
////  func value(_ key: EffectKey) -> Double {
////    
////    let animationValue: Double = store.waveform.waveStates[key]?.combinedWaveValue ?? 0
////    let amplifiedResult: Double = key.effect.amplificationStrategy.calculateAmplitude(animationValue, strength: 20)
////    //    print("Animation value: \(animationValue)")
////    
////    return amplifiedResult
////    
////  }
//}
//extension View {
//  public func jumpAnimation() -> some View {
//    self.modifier(JumpAnimationModifier())
//  }
//}
//
//private struct OtherValues {
//  var scale = 1.0
//  var verticalStretch = 1.0
//  var verticalOffset = 0.0
//  var horizontalOffset = 0.0
//  var angle = Angle.zero
//  var blur = 0.0
//  var brightness: Double = .zero
//  var opacity: Double = 1.0
//  var redFlash: Double = 0.0
//}
//
