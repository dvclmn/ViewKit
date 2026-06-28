//
//  ControlGroupStyle.swift
//  ViewKit
//
//  Created by Dave Coleman on 21/2/2026.
//

import SwiftUI

extension ControlGroupStyle where Self == CustomControlGroup {
  public func filled() -> Self {
    CustomControlGroup()
  }
}

public struct CustomControlGroup: ControlGroupStyle {
  public func makeBody(configuration: Configuration) -> some View {

    configuration.content
      .symbolRenderingMode(.hierarchical)
      .symbolVariant(.fill)
      .foregroundStyle(.secondary)

    //    configuration.label
    //    VStack {
    //      Text(title)
    //        .font(.title)
    //      HStack {
    //        configuration.content
    //      }
    //    }
  }
}
