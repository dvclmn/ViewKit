//
//  CustomToggleStyle.swift
//  BaseComponents
//
//  Created by Dave Coleman on 3/7/2025.
//

import SwiftUI

public struct CustomToggleStyle: ToggleStyle {
  public func makeBody(configuration: Configuration) -> some View {
    
    Toggle(isOn: configuration.$isOn) {
      configuration.label
        .controlSize(.regular)
    }
    .toggleStyle(.switch)
    .controlSize(.mini)
  }
}
extension ToggleStyle where Self == CustomToggleStyle {
  public static var smallSwitch: CustomToggleStyle { CustomToggleStyle() }
}
