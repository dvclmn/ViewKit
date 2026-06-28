//
//  CalendarIconView.swift
//  ViewKit
//
//  Created by Dave Coleman on 21/10/2025.
//

import CoreTools
import StringTools
import SwiftUI
import ViewTools

public struct CalendarIcon: View {
  let iconString: String

  public init(day: Int? = nil) {
    self.iconString = Date.now.dayOfTheMonthIcon(day: day)
  }

  public var body: some View {
    Image(systemName: iconString)
  }
}
