//
//  Flexi+GridView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 21/9/2025.
//

import SharedHelpers
import SwiftUI
import LayoutKit

extension Flexi {

  public enum GridFocus: Hashable {
    case item(Item.ID)
  }

  struct GridView: View {
    @Environment(FlexiHandler<Item>.self) private var store
    @Environment(\.layoutSpacing) private var layoutSpacing
    @Environment(\.modifierKeys) private var modifierKeys
    @Environment(\.isFocusable) private var isFocusable
    @Environment(\.gridConfig) private var gridConfig
    @Environment(\.gridItemSpacing) private var gridItemSpacing
    @Environment(\.gridColumnMode) private var gridColumnMode
    @Environment(\.selectionMode) private var selectionMode

    @State private var columnCount: Int?

    @State var gridHandler = GridHandler()
    @FocusState private var focused: GridFocus?

    let data: [Item]
    let content: (Item) -> Content

    var body: some View {

      @Bindable var store = store
      ScrollView(.vertical) {

        LazyVGrid(
          columns: config.columns.output,
          alignment: config.alignmentGrid,
          spacing: config.spacingGrid,
          pinnedViews: [.sectionHeaders]
        ) {

          GroupedView(
            data: data,
            groupedBy: store.groupPath,
          ) { item in

            Flexi.GridItem(
              item: item,
              focused: $focused,
              content: content
            )
            .environment(gridHandler)

          }
        }  // END lazy grid
        .scrollTargetLayout()
        .labelStyle(.base(display: .stacked))
        .task(id: focused) {
          switch focused {
            case .item(let id):
              switch selectionMode {
                case .single:
                  store.singleSelection = id

                case .multi:
                  store.multiSelection = [id]

                case .none:
                  break
              }
            case nil:
              break
          }
        }
        /// At least trying to match default List padding
        .safeAreaPadding(.horizontal, Styles.sizeMedium)

        /// This adds a little room around the edges, to account for
        /// focus effect / image border cutoff
        .safeAreaPadding(Styles.sizeTiny)
        //      .safeAreaPadding(safePadding ?? .zero)

      }  // END scroll
      .scrollPosition(id: $store.scrolledID)
      .debugTextOverlay(debugText)
      .getScrollContext(
        axis: .vertical
      ) { context in
        gridHandler.viewSize = context.containerSize
      }
      .task(id: modifierKeys) {
        gridHandler.modifiers = modifierKeys
      }
    }
  }
}

extension Flexi.GridView {

  private var debugText: AttributedString {
    return DisplayString {
      "## I'm a heading"
      DummyContent.Strings.paragraphs[3]
      Indented("## Flexi+GridView") {
        Labeled("Column count", value: self.columnCount?.toString)
        //        Labeled("Grid config", value: config.description)
        config.description
      }
    }
    .markdown()
    //    .output
    //    .monospaced(.callout)

  }

  private var config: GridConfig {
    let fallback = GridConfig(
      columnMode: gridColumnMode ?? .default,
      spacingItem: gridItemSpacing,
      spacingGrid: layoutSpacing,
      alignmentItem: nil,  // May add this to Env later
      alignmentGrid: .center
    )
    return gridConfig ?? fallback
  }

}

#if DEBUG
@available(macOS 15, iOS 18, *)
#Preview(traits: .size(.normal)) {

  @Previewable @State var store: FlexiHandler<DummyContent.Animal> = .init(mode: .single)

  /// Column maths
  ///
  /// - Width of container
  /// - Number of columns
  /// - Item spacing (horizontal) – multiplied by no. columns -1

  Flexi.GridView(data: DummyContent.Animal.data) { item in
    Rectangle()
      .fill(Color.blue.quinary)
      .frameWithAspectRatio(0.8)
  }
  .environment(
    \.gridColumnMode,
    .adaptive(.fill(min: 80, max: 140))
  )
  .environment(\.gridItemSpacing, 20)
  .environment(\.layoutSpacing, 20)
  .environment(store)
  .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)

}
#endif
