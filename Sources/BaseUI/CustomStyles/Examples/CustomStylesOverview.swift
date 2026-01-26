//
//  CustomStylesExamples.swift
//  BaseComponents
//
//  Created by Dave Coleman on 20/9/2025.
//

import CoreTools
import LayoutKit
import SwiftUI

extension EnvironmentValues {
  @Entry public var randomIcon: String = Icons.binoculars.icon
}
public struct CustomStylesOverview: View {
  @State private var displayStyles: [LabelDisplay] = LabelDisplay.allCases

  public init() {}
  public var body: some View {
    ScrollView {

      //      VStack(alignment: .leading) {
      DecomposedView(
        .section,
        layout: .vstack(alignment: .leading),
        //        layoutType: .grid(alignment: .topLeading, horizontalSpacing: Styles.sizeSmall),
        spacing: Styles.sizeRegular
      ) {

        Section("Labels") {
          Grid(
            alignment: .topLeading,
            horizontalSpacing: Styles.sizeMedium,
            verticalSpacing: Styles.sizeRegular,
          ) {
            ForEach(displayStyles) { style in

              GridRow {
                Text(style.name)
                ExampleLabel("Label Display")
                  .labelStyle(.base)
                  .environment(\.labelDisplay, style)

                  /// This ensures the `stacked` label display looks right
                  .environment(\.layoutSpacing, Styles.sizeSmall)
              }
              Divider()
            }
          }
        }
        .containerValueBool(.hasDividers, false)

        Section_Buttons()

        // MARK: - GroupBox
        Section("GroupBox") {

        }

      }  // END decomposed

      .environment(\.layoutAlignment, .leading)
      .environment(\.layoutSpacing, Styles.sizeMedium)
      .padding(Styles.sizeHuge)

    }  // END scroll view
    .environment(\.randomIcon, Icons.getRandomIcon)
  }
}
extension CustomStylesOverview {

}
#if DEBUG
@available(macOS 15, iOS 18, *)
#Preview(traits: .size(.normal)) {
  CustomStylesOverview()
}
#endif
