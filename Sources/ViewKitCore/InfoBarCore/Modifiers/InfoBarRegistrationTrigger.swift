//
//  InfoBarRegistrationTrigger.swift
//  ViewKit
//
//  Created by Dave Coleman on 23/8/2026.
//

import Foundation

struct InfoBarRegistrationTrigger<Value: Equatable>: Equatable {
  let value: Value
  let sectionID: InfoBarSectionID?
  let isEnabled: Bool
  let storeID: UUID?
}
