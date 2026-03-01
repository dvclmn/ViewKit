//
//  InfoBarSecton.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/2/2026.
//

/// Small helper struct for  processed InfoBar data
public struct InfoBarSection: Identifiable {
  public let id: InfoBarSectionID
  public let title: String
  public let items: [InfoBarItem]
  
  public init(id: InfoBarSectionID, title: String, items: [InfoBarItem]) {
    self.id = id
    self.title = title
    self.items = items
  }
}
