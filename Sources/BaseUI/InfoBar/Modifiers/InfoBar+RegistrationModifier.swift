//
//  InfoBar+RegistrationModifier.swift
//  ViewKit
//
//  Created by Dave Coleman on 23/8/2026.
//

import SwiftUI

@MainActor
struct InfoBarRegistrationModifier<Value: Equatable>: ViewModifier {
  @Environment(\.infoBarStore) private var store
  @State private var registration = InfoBarRegistration()
  
  let value: Value
  let sectionID: InfoBarSectionID?
  let isEnabled: Bool
  let makeContent: (Value) -> InfoBarRegistration.Content
  
  func body(content: Content) -> some View {
    let trigger = InfoBarRegistrationTrigger(
      value: value,
      sectionID: sectionID,
      isEnabled: isEnabled,
      storeID: store?.id
    )
    
    content
      .onChange(of: trigger, initial: true) { _, newTrigger in
        reconcile(with: newTrigger)
      }
      .onDisappear {
        registration.detach()
      }
  }
  
  private func reconcile(with trigger: InfoBarRegistrationTrigger<Value>) {
    guard trigger.isEnabled, let store else {
      registration.detach()
      return
    }
    
    registration.update(to: makeContent(trigger.value))
    registration.attach(to: store, in: trigger.sectionID)
  }
}
