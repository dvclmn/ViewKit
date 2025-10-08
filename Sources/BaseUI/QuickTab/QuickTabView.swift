//
//  SettingsView.swift
//  Components
//
//  Created by Dave Coleman on 13/2/2025.
//

//// import BaseHelpers
import SwiftUI
import SharedHelpers

public struct QuickTabView<TabItem: LabeledItem, Content: View>: View
where TabItem: CaseIterable, TabItem.AllCases: RandomAccessCollection {

  @Binding var tab: TabItem
  let tabContent: (TabItem) -> Content

  public init(
    tab: Binding<TabItem>,
    @ViewBuilder tabContent: @escaping (TabItem) -> Content
  ) {
    self._tab = tab
    self.tabContent = tabContent
  }

  public var body: some View {

    if #available(macOS 15, iOS 18, *) {

      TabView(selection: $tab) {
        ForEach(TabItem.allCases) { tabItem in
          Tab(value: tabItem) {
            Form {
              tabContent(tabItem)
            }  // END form
          } label: {
            MaybeLabel(tabItem.label)
          }
        }  // END foreach
      }

    } else {
      TabView {
        ForEach(TabItem.allCases) { tab in
          Form {
            tabContent(tab)
              .tabItem {
                MaybeLabel(tab.label)
              }
          }
          .padding(Styles.sizeLarge)
        }
      }
    }
  }
}
