//
//  CalendarIconView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/10/2025.
//

import SwiftUI
import CoreTools
import ViewTools

public struct CalendarIcon: View {
//  var day: Int
let iconString: String
  
  public init(day: Int? = nil) {
    self.iconString = Date.now.dayOfTheMonthIcon(day: day)
  }
  
  public var body: some View {
    Image(systemName: iconString)
  }
}
