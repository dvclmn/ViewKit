//
//  LabelExamples.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/3/2025.
//

import CoreTools
import SwiftUI

public struct LabelExampleView: View {

  let elementPickerItemSize: CGSize = .init(100, 80)
  public var body: some View {

    ScrollView {
      VStack(alignment: .leading, spacing: Styles.sizeMedium) {

        CardGrid(data: SampleContent.Animal.withSymbols()) { item in
//        CardGrid(data: SampleContent.Animal.withSymbols()) { item, isHovered in
//          let label =
//            isHovered
//            ? QuickLabel("Remove", icon: .preset(.trash), role: .destructive)
//            : item.label

          MaybeLabel(item.label)
            .containerValueBool(.isEmphasised, item == SampleContent.Animal.withSymbols()[2])

        }
        //        CardGrid(data: SampleContent.Animal.withEmojis()) {
        //          MaybeLabel($0.label)
        //        }

        ExampleLabel("Native Automatic Style")
          .labelStyle(.automatic)

        ExampleLabel("Base Custom Label")
          .labelStyle(.base)

        GroupBox("MaybeLabels") {
          MaybeLabel("One with title")
          MaybeLabel(QuickLabel("Got an Emoji", icon: .emoji("🛼")))
          MaybeLabel("With title and icon", icon: .symbol("car"))
        }
        .groupBoxStyle(.custom)

      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.black.secondary)

  }
}
extension LabelExampleView {
  @ViewBuilder
  func ExampleLabel(_ title: String) -> some View {
    Label(title, systemImage: Icons.getRandomIcon)
  }
}
#if DEBUG
@available(macOS 15, iOS 18, *)
#Preview(traits: .size(.normal)) {
  LabelExampleView()
}
#endif
