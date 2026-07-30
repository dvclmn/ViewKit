//
//  LabelStyle+Exts.swift
//  ViewKit
//
//  Created by Dave Coleman on 30/7/2026.
//

import SwiftUI

extension LabelStyle where Self == CustomLabel {
  public static var base: Self { Self() }
  
  /// If no value supplied for `display`, will use environment value,
  /// or fall back to `.titleAndIcon`
  public static func base(display: LabelDisplay?) -> Self { Self(labelDisplay: display) }
}
