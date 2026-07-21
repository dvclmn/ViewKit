//
//  SettingsView.swift
//  Components
//
//  Created by Dave Coleman on 13/2/2025.
//

import CoreTools
import SwiftUI
import ViewTools

public struct QuickTabView<TabItem: LabeledItem & Hashable, Content: View>: View {

  @Binding var selection: TabItem
  let sourceData: [TabItem]

  let tabContent: (TabItem) -> Content

  public init(
    selection: Binding<TabItem>,
    sourceData: [TabItem],
    @ViewBuilder tabContent: @escaping (TabItem) -> Content,
  ) {
    self._selection = selection
    self.sourceData = sourceData
    self.tabContent = tabContent
  }

  public var body: some View {

    if #available(macOS 15, iOS 18, *) {
      TabView(selection: $selection) {
        ForEach(sourceData) { tabItem in
          Tab(value: tabItem) {
            //            Form {
            tabContent(tabItem)
            //            }  // END form
          } label: {
            QuickLabel(tabItem.label)
          }
        }  // END foreach
      }

    } else {
      TabView(selection: $selection) {
        ForEach(sourceData) { tab in
          //          Form {
          tabContent(tab)
            .tag(tab)
            .tabItem {
              QuickLabel(tab.label)
            }
            //          }
            .padding(Styles.sizeLarge)
        }
      }
    }
  }
}

extension QuickTabView where TabItem: CaseIterable {
  public init(
    selection: Binding<TabItem>,
    @ViewBuilder tabContent: @escaping (TabItem) -> Content,
  )
  where
    TabItem.AllCases: RandomAccessCollection, TabItem.AllCases.Element == TabItem,
    TabItem.AllCases == [TabItem]
  {
    self.init(
      selection: selection,
      sourceData: TabItem.allCases,
      tabContent: tabContent,
    )
  }
  //  public init(
  //    title: String,
  //    selection: Binding<TabItem>,
  //  ) where TabItem.AllCases: RandomAccessCollection, TabItem.AllCases.Element == TabItem, TabItem.AllCases == [TabItem] {
  //    self.title = title
  //    self._selection = selection
  //    self.sourceData = Item.allCases
  //  }
}

//where TabItem: CaseIterable, TabItem.AllCases: RandomAccessCollection
