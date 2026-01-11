//
//  EnvValues+Debug.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/1/2026.
//

import SwiftUI

extension EnvironmentValues {
  
  /// Meant as a debug helper, for when I'm not sure who is
  /// consuming this View, or what it's context is.
  @Entry public var viewDescription: String? = nil
}
