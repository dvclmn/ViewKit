//
//  PopupMessageTests.swift
//  ViewKit
//
//  Created by Dave Coleman on 9/8/2026.
//

@testable import BaseUI
import Testing

@Suite("Popup message dismissal")
struct PopupMessageTests {
  @Test("short informational messages dismiss automatically")
  func informationalMessagesDismissAutomatically() {
    let message = PopupMessage.make("Saved")

    #expect(message.dismissal == .automatic())
  }

  @Test("actionable messages remain until dismissed")
  func actionableMessagesRemainVisible() {
    let message = PopupMessage.make(
      "Exported",
      actions: PopupAction(title: "Show in Finder") {}
    )

    #expect(message.dismissal == .manual)
  }

  @Test("loading messages remain until replaced")
  func loadingMessagesRemainVisible() {
    let message = PopupMessage.make(
      "Exporting",
      loading: .indeterminate
    )

    #expect(message.dismissal == .manual)
  }

  @Test("invalid automatic durations behave as manual dismissal")
  func invalidAutomaticDurationsDoNotScheduleDismissal() {
    #expect(PopupDismissBehaviour.automatic(.infinity).autoDismissDuration == nil)
    #expect(PopupDismissBehaviour.automatic(.nan).autoDismissDuration == nil)
    #expect(PopupDismissBehaviour.automatic(-1).autoDismissDuration == 0)
  }
}
