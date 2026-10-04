//
//  TextTag.swift
//  BaseComponents
//
//  Created by Dave Coleman on 20/7/2025.
//

import ColourTools
import CoreTools
import SwiftUI
import ViewTools

public struct TextTag: View {
  @Environment(\.self) private var envSelf
  let text: String
  let colour: RGBColour
  //  let colour: Color

  public init(
    _ text: String,
    colour: RGBColour,
    //    colour: ColourDescriptor = Color.gray.opacityLow
  ) {
    self.text = text
    self.colour = colour
  }

  public var body: some View {

    Text(text)
      .fontWeight(.semibold)
      //      .foregroundStyle(.secondary)
      .foregroundStyle(
        colour.contrastColour(
          strength: .moderate,
          purpose: .complementary,
          chroma: .monochrome,
        ).toColour
        //          .contrastColour(
        //          strength: .moderate,
        //          purpose: .complementary,
        //          chroma: .monochrome,
        //          environment: envSelf
        //        ).colour
      )
      .quickBackground(
        shape: .rect(cornerRadius: Styles.sizeTiny),
//        padding: 2,
//        tint: colour.toColour
        style: .standard(tint: colour.toColour)
      )
//      .backgroundTint(colour.toColour)
      
      .environment(\.strokeColour, colour.toColour.toShapeStyle)
      .environment(\.strokeWeight, 1)
  }
}
//#if DEBUG
//@available(macOS 15, iOS 18, *)
//#Preview(traits: .size(.normal)) {
//  TextTag("Hello")
//    .padding(100)
//}
//#endif

//public struct TextTagModifier: ViewModifier {
//
////  let text: String
//  public func body(content: Content) -> some View {
//    HStack(alignment: .firstTextBaseline) {
//      content
////      Text(text)
//
//    }
//  }
//}
//extension View {
//  public func textTag() -> some View {
////  public func textTag(_ text: String) -> some View {
//    self.modifier(TextTagModifier())
//  }
//}
