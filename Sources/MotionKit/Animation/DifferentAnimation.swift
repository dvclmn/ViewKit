//
//  DifferentAnimation.swift
//  BaseComponents
//
//  Created by Dave Coleman on 15/8/2025.
//

import SwiftUI

@available(macOS 14.0, *)
public struct DifferentAnimationModifier: ViewModifier {
  
  @State private var tapCount = 1
  
  let emojiBaseSize: CGFloat
  
  init(emojiBaseSize: CGFloat = 100) {
    self.emojiBaseSize = emojiBaseSize
  }
  
  public func body(content: Content) -> some View {
    content
      .keyframeAnimator(
        initialValue: JumpAnimationValues(),
        //              repeating: true
        trigger: tapCount
      ) { content, value in
        content
          .rotationEffect(value.angle, anchor: .bottom)
          .scaleEffect(value.scale, anchor: .bottom)
          .scaleEffect(y: value.verticalStretch, anchor: .bottom)
          .offset(y: value.verticalOffset)
          .offset(x: value.horizontalOffset)
          .blur(radius: value.blur)
      } keyframes: { _ in
        
        KeyframeTrack(\.scale) {
          LinearKeyframe(1.0, duration: 0.36)
          SpringKeyframe(1.3, duration: 1.8, spring: .bouncy)
          SpringKeyframe(1.0, spring: .bouncy)
        }
        
        KeyframeTrack(\.verticalOffset) {
          LinearKeyframe(0.0, duration: 0.28)
          CubicKeyframe(-emojiBaseSize, duration: 0.2)
          LinearKeyframe(-(emojiBaseSize + 7), duration: 1.7)
          CubicKeyframe(0.0, duration: 0.2)
          LinearKeyframe(0.0, duration: 2.0)
        }
        
        KeyframeTrack(\.verticalStretch) {
          CubicKeyframe(1.0, duration: 0.2)
          CubicKeyframe(0.4, duration: 0.08)
          CubicKeyframe(1.4, duration: 0.1)
          CubicKeyframe(1.0, duration: 0.2)
          LinearKeyframe(1.0, duration: 1.5)
          SpringKeyframe(1.4, duration: 0.1, spring: .bouncy)
          SpringKeyframe(1.0, duration: 0.1, spring: .bouncy)
          LinearKeyframe(1.0, duration: 0.1)
        }
        
        KeyframeTrack(\.horizontalOffset) {
          LinearKeyframe(0.0, duration: 0.5)
          SpringKeyframe(8.0, duration: 1.8, spring: .bouncy(duration: 0.2, extraBounce: 0.5))
          LinearKeyframe(0.0, duration: 0.2)
          //                CubicKeyframe(0.0, duration: 0.2)
          
        }
        
        KeyframeTrack(\.blur) {
          CubicKeyframe(0.0, duration: 0.3)
          CubicKeyframe(3.0, duration: 0.1)
          CubicKeyframe(0.0, duration: 0.1)
          LinearKeyframe(0.0, duration: 1.7)
          CubicKeyframe(3.0, duration: 0.1)
          CubicKeyframe(0.0, duration: 0.1)
          LinearKeyframe(0.0, duration: 0.1)
        }
        
        KeyframeTrack(\.angle) {
          
          LinearKeyframe(.zero, duration: 0.1)
          CubicKeyframe(.degrees(19), duration: 0.2)
          CubicKeyframe(.degrees(-8), duration: 0.2)
          CubicKeyframe(.degrees(-15), duration: 1.7)
          //                SpringKeyframe(.degrees(4), duration: 0.2, spring: .bouncy)
          SpringKeyframe(.degrees(18), duration: 0.08, spring: .bouncy)
          SpringKeyframe(.zero, duration: 0.1, spring: .bouncy)
          LinearKeyframe(.zero, duration: 0.1)
          
        }
        
      }
      .onTapGesture {
        tapCount += 1
      }
  }
}

@available(macOS 14.0, *)
extension View {
  public func differentAnimation() -> some View {
    self.modifier(DifferentAnimationModifier())
  }
}

private struct JumpAnimationValues {
  var scale = 1.0
  var verticalStretch = 1.0
  var verticalOffset = 0.0
  var horizontalOffset = 0.0
  var angle = Angle.zero
  var blur = 0.0
}
