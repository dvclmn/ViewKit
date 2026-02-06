//
//  RandomDiceIcon.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import SwiftUI

public struct RandomDiceLabel<V: Equatable>: View {
  let title: String
  let angle: AngleAdjustment
  let rollTrigger: V

  public init(
    _ title: String,
    rollTrigger: V,
    angle: AngleAdjustment = .default
  ) where V: Equatable {
    self.title = title
    self.angle = angle
    self.rollTrigger = rollTrigger
  }

  //  public init(_ title: String, adjustsAngle: Bool) where V == Int {
  //    self.title = title
  //    self.angle = adjustsAngle ? .default : .none
  //    self.rollTrigger = 0
  //  }

  public var body: some View {
    Label {
      Text(title)
    } icon: {
      RandomDiceIcon(rollTrigger: rollTrigger, angle: angle)
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

public struct RandomDiceIcon<V: Equatable>: View {

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
  let rollTrigger: V

  @State private var face: Int = 6
  @State private var rotation: Double = 0

  public init(rollTrigger: V, angle: AngleAdjustment = .default) {
    self.rollTrigger = rollTrigger
    self.angle = angle
  }

  public var body: some View {
    Image(systemName: iconMap[face] ?? "die.face.6")
      .symbolRenderingMode(.hierarchical)
      .symbolVariant(.fill)
      .rotationEffect(.degrees(rotation))
      .task(id: rollTrigger) {
        reroll()
      }
      .task {
        if face == 6 {
          reroll()
        }
      }
  }

  private func reroll() {
    face = Int.random(in: 1...6)
    rotation = Double.random(in: -angle.adjustment...angle.adjustment)
  }
}
