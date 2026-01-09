//
//  HBarExampleView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/5/2025.
//

import CoreTools
import SwiftUI

public struct InfoBarExampleView: View {

  let store = ExampleStore()

  public var body: some View {

    VStack {

      Text("Content")
        //        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.purple.quinary)
        .safeAreaPadding(.bottom, Styles.infoBarHeight)

    }
    //    .addInfoBarItems()

    //      InfoBar(items: InfoBarItems)
    //      //      InfoBar(type: ExampleItem.self) { section, hovered in
    //
    //      switch section {
    //
    //        case .counts:
    //
    //          Group {
    //            LabeledContent("Touches", value: store.touchCount.toString)
    //            LabeledContent("Touches", value: store.touchCount.toString)
    //            LabeledContent("Touches", value: store.touchCount.toString)
    //            //  //            Text(store.touchCount.string)
    //            //              Text(store.strokeCountActive.string)
    //            //              Text(store.pointCountFiltered.string)
    //          }
    //          //            .padding(Styles.sizeNano)
    //          .quickBackground()
    //
    //        case .strokeCountCompleted:
    //          //            InfoBarItem(section) {
    //          Text(store.strokeCountCompleted.toString)
    //          //            }
    //
    //        case .touchModeActive:
    //          //            InfoBarItem(section) {
    //          Text(store.isInDrawingMode.description)
    //          //            }
    //
    //        case .pointerLocked:
    //          //            InfoBarItem(section) {
    //          Text(store.isPointerLocked.description)
    //          //            }
    //
    //        case .clickedDown:
    //          Text(store.isClicked.description)
    //
    //        case .pressure:
    //          Text(store.isClicked.description)
    //
    //      }

    //        Text(item.name)
    //          .gridCellAnchor(.leading)
    //        Text(valueString(item))
    //          .gridCellAnchor(.trailing)
    //          .fontWeight(.medium)
    //          .monospaced()
    //    )
    //      .setLayout(axis: .horizontal)
    //      .setCompactMode(true)
    //      .labeledContentStyle(.custom)
    //  }
    //    }
    .infoBarView()
    //    .overlay(alignment: .bottom) {
    .frame(width: 700, height: 740)

  }
}

extension InfoBarExampleView {
  var infobarItems: [InfoBarItem] {

    //    let items: [CanvasInfoItem] = [.pan, .zoomPercent, .interaction]
    //    let items = ExampleItem.allCases
    //    return items.map { item in
    //      return InfoBarItem(
    //        section: ExampleItem.sectionTitle,
    //        label: QuickLabel(item.title, icon: item.icon),
    //        content: item.content(
    //          canvasHandler,
    //          modifiers: modifierKeys
    //        )
    //        //        content: content(item)
    //      )
    //    }
  }
}

#if DEBUG
@available(macOS 15, iOS 18, *)
#Preview(traits: .size(.normal)) {
  InfoBarExampleView()
}
#endif

struct ExampleStore {
  var currentPressure: CGFloat? = 0
  var isPointerLocked: Bool = false
  var isInDrawingMode: Bool = false
  var isClicked: Bool = false
  var strokeCountCompleted: Int = 18
  var touchCount: Int = 3
  var strokeCountActive: Int = 1
  var pointCountFiltered: Int = 1492
}

public enum ExampleItem: String, Sendable, InfoBarSection {

  //public enum ExampleItem: String, InfoBarSection {

  case counts
  //  case touchCount
  //  case strokeCountActive
  //  case pointCountFiltered
  case strokeCountCompleted
  case touchModeActive
  case pointerLocked
  case clickedDown
  case pressure

  public static var section: String { "Example" }

  public var label: QuickLabel { QuickLabel(self.name) }

  public static let itemsKey: String = "InfoBarItems"
  //  public let elements: [Self] = [

  public static let defaultItems: Set<Self> = [
    .counts,
    //    .touchCount,
    //    .pointCountFiltered,
    .touchModeActive,
    .pointerLocked,
    .pressure,
  ]

  public var id: String { self.rawValue }

  public var name: String {
    switch self {
      case .counts: "Counts"
      //      case .touchCount: "Touch Count"
      //      case .strokeCountActive: "Strokes (Active)"
      //      case .pointCountFiltered: "Points (Filtered)"
      case .strokeCountCompleted: "Strokes (Completed)"
      case .touchModeActive: "Touch Mode Active"
      case .pointerLocked: "Pointer Locked"
      case .clickedDown: "Clicked Down"
      case .pressure: "Pressure"
    }
  }

}
