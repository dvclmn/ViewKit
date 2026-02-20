//
//  InfoBarSecton.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/2/2026.
//

/// Small helper struct for  processed InfoBar data
public struct InfoBarSection: Identifiable {
  public let id: InfoBarSectionID
  let title: String
  let items: [InfoBarItem]
}
