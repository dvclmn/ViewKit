//
//  Throttler.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/12/2025.
//

import Foundation
import Quartz

/// ```
/// func drawBackgroundForLayer(_ layer: GSLayer) {
///   throttler.execute {
///     self.rebuildIfNeeded(layer)
///   }
///
///   drawCachedStuff()
/// }
/// ```
//@MainActor
//public final class Throttler {
//  private let interval: TimeInterval
//  private var lastFire: CFTimeInterval = 0
//  
//  public init(interval: TimeInterval = 0.2) {
//    self.interval = interval
//  }
//  
//  public func execute(_ action: () -> Void) {
//    let now = CACurrentMediaTime()
//    guard now - lastFire >= interval else { return }
//    
//    lastFire = now
//    action()
//  }
//}

//@MainActor
//public final class LeadingDebouncer {
//  private let interval: TimeInterval
//  private var lastFire: CFTimeInterval = 0
//  private var pending = false
//  
//  public init(interval: TimeInterval = 0.2) {
//    self.interval = interval
//  }
//  
//  public func execute(_ action: @escaping () -> Void) {
//    let now = CACurrentMediaTime()
//    
//    if now - lastFire >= interval {
//      lastFire = now
//      action()
//      return
//    }
//    
//    guard !pending else { return }
//    pending = true
//    
//    DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
//      self.pending = false
//      self.lastFire = CACurrentMediaTime()
//      action()
//    }
//  }
//}
