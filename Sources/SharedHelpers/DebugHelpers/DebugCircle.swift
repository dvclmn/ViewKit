//
//  DebugCircle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/7/2025.
//

import SwiftUI

public struct DebugCircleModifier: ViewModifier {

  let location: CGPoint?
  let size: CGFloat
  public func body(content: Content) -> some View {
    content
      .overlay {
        if let location {
          ZStack {
            Circle()
              .fill(.purple)
              .frame(width: size, height: size)

            Text(location.debugDescription)

              .font(.caption)
              .padding(4)
              .background(.thinMaterial)
              .clipShape(.rect(cornerRadius: 3))
              .offset(y: -size * 2)
          }  // END zstack
          .position(location)
        }
      }
  }
}
extension View {
  public func debugCircle(
    _ location: CGPoint?,
    size: CGFloat = 10,
  ) -> some View {
    self.modifier(
      DebugCircleModifier(
        location: location,
        size: size,
      )
    )
  }
}

//public struct DebugPointModifier: ViewModifier {
//  
//  let colour: Color
//  let text: String
//  let position: CGPoint?
//  
//  public init(
//    colour: Color,
//    text: String,
//    position: CGPoint?
//  ) {
//    self.colour = colour
//    self.text = text
//    self.position = position
//  }
//  
//  public func body(content: Content) -> some View {
//    GeometryReader { proxy in
//      content
//      if let position {
//        ZStack {
//          Text(text)
//            .font(.system(size: 9))
//            .foregroundStyle(colour)
//            .offset(x: -10, y: -14)
//          
//          Circle()
//            .fill(colour)
//            .frame(width: Styles.sizeTiny, height: Styles.sizeTiny)
//        }
//        .position(position)
//      } else {
//        EmptyView()
//      }
//      
//    }
//  }
//}
//
//extension View {
//  public func debugPoint(
//    colour: Color,
//    text: String,
//    position: CGPoint?
//  ) -> some View {
//    self.modifier(
//      DebugPointModifier(colour: colour, text: text, position: position)
//    )
//  }
//}
