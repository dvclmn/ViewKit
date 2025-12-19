//
//  CharacterSizeTest.swift
//  SumBuddy
//
//  Created by Dave Coleman on 31/10/2025.
//

import CoreTools
import SwiftUI
import LayoutKit

@available(macOS 14.0, *)
public struct CharacterSizes: View {
  public var body: some View {

    ScrollView {
      VStack(spacing: Styles.sizeLarge) {
        CharacterSizeTest(fontSize: 12)
        CharacterSizeTest(fontSize: 28)
        CharacterSizeTest(fontSize: 56)
      }
      .padding()
    }

  }
}

@available(macOS 14.0, *)
public struct CharacterSizeTest: View {

  @State private var sizesM: [GridFont: CGSize] = [:]
  @State private var sizesX: [GridFont: CGSize] = [:]

  let fontSize: CGFloat
  //  let font: GridFont

  public var body: some View {

    Grid(alignment: .leading, verticalSpacing: Styles.sizeRegular) {
      ForEach(GridFont.allCases) { fontStyle in
        GridRow {
          Text(fontStyle.name)
            .font(.callout)
            .foregroundStyle(.tertiary)
            .lineLimit(1)

          SingleTest(for: fontStyle)

          HStack {
            Group {
              Text("m: \(sizeText(for: sizesM[fontStyle]))")

              Text("X: \(sizeText(for: sizesX[fontStyle]))")
            }
            //            .quickBackground()
          }
          .tint(Color.orange.opacity(sizesDoMatch(for: fontStyle) ? 0.0 : 0.2))
          .font(.callout.monospaced())
          .foregroundStyle(.secondary)
        }  // END row
      }

    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)

  }
}

@available(macOS 14.0, *)
extension CharacterSizeTest {

  private func sizesDoMatch(for style: GridFont) -> Bool {
    let lhs = sizesM[style]
    let rhs = sizesX[style]
    return lhs == rhs
  }

  private func sizeText(for size: CGSize?) -> String {
    return size?.displayString(places: 2, labelStyle: .none) ?? "nil"
  }

  @ViewBuilder
  private func SingleTest(for style: GridFont) -> some View {
    HPack {
      Group {
        Text("m")
          .viewSize(mode: .debounce(0.2)) { size in
            print("M character size: \(size)")
            self.sizesM[style] = size
          }
        Text("M")
        Text("╳")
          .viewSize(mode: .debounce(0.2)) { size in
            self.sizesX[style] = size
          }

        Text("╚")
        Text("░")
        Text("a")
      }
      .fixedSize()
      .background(Color.mint.opacity(0.1))
      .border(Color.mint.opacity(0.5))
    }
    .gridFont(style, size: fontSize)
  }
}
#if DEBUG
@available(macOS 14.0, *)
#Preview {
//#Preview(traits: .size(.normal)) {
  //  VStack {
  //    CharacterSizeTest(font: .sfMono)
  //    CharacterSizeTest()
  CharacterSizes()
  //  }
  //  .padding(100)
}
#endif
