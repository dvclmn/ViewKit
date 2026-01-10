//
//  ViewDescriptionModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/10/2025.
//

#if DEBUG

import SwiftUI

public struct ViewDescriptionModifier: ViewModifier {
  @Environment(\.viewDescription) private var viewDescription
  @Environment(\.isDebugMode) private var isDebugMode
  //  let label: String
  //  let labelOpacity: CGFloat
  //  let colour: Color
  //  let isEnabled: Bool
  //
  public func body(content: Content) -> some View {
    content
      .overlay(alignment: .bottomTrailing) {
        if let viewDescription, isDebugMode {
          Text(viewDescription)
            .font(.callout)
            .foregroundStyle(.secondary)
            .padding(Styles.sizeTiny)
            .background(Color.black.opacity(0.4))
            .background(.regularMaterial)
            .padding()
        }
      }
    //      .border(colour.opacity(isEnabled ? 0.2 : 0.0), width: 1)
    //      .overlay(alignment: .topLeading) {
    //        if isEnabled, !label.isEmpty {
    //          Text(label)
    //            .foregroundStyle(colour.opacity(0.8))
    //            .background(Color.black.opacity(0.8))
    //            .opacity(labelOpacity)
    //            .padding(Styles.sizeSmall)
    //        }
    //      }
  }
}
extension View {
  public func
    viewDescriptionOverlay(//    _ text: String,
    //    _ colour: Color,
    //    labelOpacity: CGFloat = 0.85,
    //    isEnabled: Bool = true
    ) -> some View
  {
    self.modifier(
      ViewDescriptionModifier()
    )
  }
}
#endif
