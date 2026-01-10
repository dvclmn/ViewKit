//
//  SynchronousDebouncer.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/12/2025.
//

@preconcurrency import Foundation
import Quartz

@MainActor
public final class RateLimiter {

  public struct Behaviour: OptionSet, Sendable {
    public let rawValue: Int

    /// Execute immediately when first called
    public static let leading = Behaviour(rawValue: 1 << 0)

    /// Execute once after calls stop
    public static let trailing = Behaviour(rawValue: 1 << 1)

    public init(rawValue: Int) {
      self.rawValue = rawValue
    }
  }

  private let interval: TimeInterval
  private let behaviour: Behaviour

  private var lastFire: CFTimeInterval = 0
  private var pendingWorkItem: DispatchWorkItem?

  public init(
    interval: TimeInterval,
    behaviour: Behaviour = [.leading]
  ) {
    self.interval = interval
    self.behaviour = behaviour
  }

  public func execute(_ action: @escaping () -> Void) {
    let now = CACurrentMediaTime()
    let elapsed = now - lastFire

    if behaviour.contains(.leading), elapsed >= interval {
      lastFire = now
      action()
      return
    }

    guard behaviour.contains(.trailing) else { return }

    pendingWorkItem?.cancel()

    let item = DispatchWorkItem { [weak self] in
      self?.lastFire = CACurrentMediaTime()
      action()
    }

    pendingWorkItem = item

    DispatchQueue.main.asyncAfter(
      deadline: .now() + interval,
      execute: item
    )
  }

  deinit {
    pendingWorkItem?.cancel()
  }
}

/// This is fine if you’re debouncing rebuilds, analysis, caches, etc — not direct drawing.
//@MainActor
//public final class Debouncer {
//  private var workItem: DispatchWorkItem?
//  private let interval: TimeInterval
//
//  public init(interval: TimeInterval = 0.2) {
//    self.interval = interval
//  }
//
//  public func execute(_ action: @escaping () -> Void) {
//    workItem?.cancel()
//
//    let item = DispatchWorkItem { action() }
//    workItem = item
//
//    DispatchQueue.main.asyncAfter(
//      deadline: .now() + interval,
//      execute: item
//    )
//  }
//
//  deinit {
//    workItem?.cancel()
//  }
//}
