//
//  RandomDiceIcon.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import SwiftUI

public struct RandomDiceLabel: View {
  let title: String
  let angle: AngleAdjustment
  public init(_ title: String, angle: AngleAdjustment = .default) {
    self.title = title
    self.angle = angle
  }
  public var body: some View {

    Label {
      Text(title)
    } icon: {
      RandomDiceIcon(angle: angle)
    }

  }
}

public enum AngleAdjustment: Sendable {
  case adjust(degrees: Double)
  case none

  public static let `default`: Self = .adjust(degrees: 6)

  var adjustment: Double {
    switch self {
      case .adjust(let degrees): degrees
      case .none: 0
    }
  }
}

public struct RandomDiceIcon: View {
  
  let diceFaces: [Int] = [1, 2, 3, 4, 5, 6]
  let iconMap: [Int: String] = [
    1: "die.face.1",
    2: "die.face.2",
    3: "die.face.3",
    4: "die.face.4",
    5: "die.face.5",
    6: "die.face.6",
  ]
  let angle: AngleAdjustment

  public init(angle: AngleAdjustment = .default) {
    self.angle = angle
  }
  public var body: some View {
    Image(systemName: randomFace)
      .symbolRenderingMode(.hierarchical)
      .symbolVariant(.fill)
      .rotationEffect(
        Angle(
          degrees: Double.random(in: -angle.adjustment...angle.adjustment)
        )
      )
  }
}

extension RandomDiceIcon {
  private var randomFace: String {
    iconMap[diceFaces.randomElement() ?? 6] ?? "die.face.6"
  }
}
//#if DEBUG
//#Preview(traits: .size(.normal)) {
//  // @Previewable @State var store = AppHandler()
//  RandomDiceIcon()
//  // .environment(store)
//}
//#endif
