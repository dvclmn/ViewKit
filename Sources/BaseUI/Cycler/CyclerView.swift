//
//  CaseCyclable.swift
//  Components
//
//  Created by Dave Coleman on 18/1/2025.
//


import BasePrimitives
import SwiftUI

public struct Cycler<Item: CaseCyclable, Label: View>: View {
  @Environment(\.emphasisColour) private var emphasisColour
  @Environment(\.labelColour) private var labelColour

  @Binding var item: Item
  let label: (Item) -> Label

  public init(
    item: Binding<Item>,
    @ViewBuilder label: @escaping (Item) -> Label
  ) {
    self._item = item
    self.label = label
  }

  public var body: some View {

    Button {
      item.moveForward()
    } label: {
      label(item)
      //      MaybeLabel(item.label)
      //        .foregroundStyle(labelColour ?? AnyShapeStyle(.primary))
    }
    .tint(emphasisColour)
  }
}
