//
//  Env+Infobar.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/3/2026.
//

import SwiftUI

extension EnvironmentValues {
  @Entry public var sectionLabelDisplay: LabelDisplay? = nil
  @Entry public var itemLabelDisplay: LabelDisplay? = nil
  @Entry public var isInfoBarPresent: Bool = false
  @Entry public var shouldShowInfoBarItems: Bool = false
  
}
