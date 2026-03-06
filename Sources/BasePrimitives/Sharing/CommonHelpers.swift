//
//  CommonHelpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/2/2026.
//

import Sharing
import SwiftUI

//public protocol SharedSettable {
////  associatedtype SharedType: _BoxReference & Observable
////  associatedtype SharedType: MutableReference & Observable
//  
//  func setPref<T>(_ keyPath: WritableKeyPath<Preferences, T>, value: T) {
//    self.$prefs.withLock { $0[keyPath: keyPath] = value }
//  }
//  
//  func setPref(perform change: (inout Preferences) -> Void) {
//    self.$prefs.withLock { change(&$0) }
//  }
//}
