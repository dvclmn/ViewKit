//
//  SettingsView.swift
//  Components
//
//  Created by Dave Coleman on 13/2/2025.
//

import CoreTools
import SwiftUI
import ViewTools

public struct QuickTabView<
  TabItem: Identifiable & Hashable,
  TabLabel: View,
  Content: View,
>: View {

  @Binding var selection: TabItem
  let sourceData: [TabItem]

  let label: (TabItem) -> TabLabel
  let content: (TabItem) -> Content

  public init(
    selection: Binding<TabItem>,
    sourceData: [TabItem],
    @ViewBuilder label: @escaping (TabItem) -> TabLabel,
    @ViewBuilder content: @escaping (TabItem) -> Content,
  ) {
    self._selection = selection
    self.sourceData = sourceData
    self.label = label
    self.content = content
  }

  public var body: some View {

    if #available(macOS 15, iOS 18, *) {
      TabView(selection: $selection) {
        ForEach(sourceData) { tab in
          Tab(value: tab) {
            //            Form {
            content(tab)
            //            }  // END form
          } label: {
            label(tab)
            //            QuickLabel(tabItem.label)
          }
        }  // END foreach
      }

    } else {
      TabView(selection: $selection) {
        ForEach(sourceData) { tab in
          //          Form {
          content(tab)
            .tag(tab)
            .tabItem {
              label(tab)
              //              QuickLabel(tab.label)
            }
            //          }
            .padding(Styles.sizeLarge)
        }
      }
    }
  }
}

extension QuickTabView {
  public init(
    selection: Binding<TabItem>,
    @ViewBuilder content: @escaping (TabItem) -> Content,
  )
  where
    TabItem: CaseIterable & LabeledItem, TabItem.AllCases: RandomAccessCollection,
    TabItem.AllCases.Element == TabItem,
    TabItem.AllCases == [TabItem], TabLabel == QuickLabel
  {
    self.init(
      selection: selection,
      sourceData: TabItem.allCases,
      label: { item in
        QuickLabel(item.label)
      },
      content: content,
    )
  }
}

extension QuickTabView {
  public init(
    selection: Binding<TabItem>,
    sourceData: [TabItem],
    @ViewBuilder content: @escaping (TabItem) -> Content,
  )
  where TabItem: LabeledItem, TabLabel == QuickLabel {
    self.init(
      selection: selection,
      sourceData: sourceData,
      label: { item in
        QuickLabel(item.label)
      },
      content: content,
    )
  }
}
