//
//  TrafficLightsView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 31/8/2025.
//

import BasePrimitives
import CoreUtilities
import SwiftUI

public struct TrafficLightsModifier: ViewModifier {
  public func body(content: Content) -> some View {
    content
      .overlay(alignment: .topLeading) {
        if isPreview {
          HStack {

            Circle()
              .fill(Color(hex: "FE6057") ?? Color.red)

            Circle()
              .fill(Color(hex: "FFBC2E") ?? Color.yellow)

            Circle()
              .fill(Color(hex: "28C840") ?? Color.green)

          }
          .frame(height: 12)
          .padding(20)
        }
      }
  }
}
extension View {
  public func trafficLightsPreview() -> some View {
    self.modifier(TrafficLightsModifier())
  }
}
