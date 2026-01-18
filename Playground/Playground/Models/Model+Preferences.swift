//
//  Model+Example.swift
//  TemplateProject
//
//  Created by Dave Coleman on 27/5/2025.
//

import Foundation
import ToolKit

nonisolated
struct Preferences: ModelBase {
  var isShowingInspector: Bool = false
  var tab: PlaygroundTab = .lilypad
}
