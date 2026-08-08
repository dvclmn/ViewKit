//
//  DividedGridView.swift
//  ViewKit
//
//  Created by Dave Coleman on 5/8/2026.
//

import SwiftUI

public struct DividedGrid<Content: View>: View {
  private let alignment: Alignment
  private let content: Content

  public init(
    alignment: Alignment = .center,
    @ViewBuilder content: () -> Content,
  ) {
    self.alignment = alignment
    self.content = content()
  }

  public var body: some View {
    Grid(alignment: alignment) {
      if #available(macOS 15, iOS 18, *) {
        GridContent {
          content
        }
      } else {
        content
      }
    }
  }
}

@available(macOS 15, iOS 18, *)
extension DividedGrid {

  struct GridContent: View {
    private let content: Content

    init(
      @ViewBuilder content: @escaping () -> Content
    ) {
      self.content = content()
    }

    var body: some View {
      Group(subviews: content) { subviews in
        ForEach(subviews: subviews) { subview in
          subview
          //            .border(Color.green.opacity(subview.id != subviews.last?.id ? 0.3 : 1.0))

          if subview.id != subviews.last?.id {
//            GridRow {
              Divider()
              //                          .gridCellColumns(2)
//            }
          }
        }
      }  // END group

    }
  }

}

//extension DividedGrid {
//  public struct GridContent<Content: View>: View {
//    private let content: Content
//
//    init(@ViewBuilder content: () -> Content) {
//      self.content = content()
//    }
//
//    var body: some View {
//      Group(subviews: content) { subviews in
//        ForEach(subviews) { subview in
//          subview
//
//          if subview.id != subviews.last?.id {
//            Divider()
//              .gridCellColumns(2)
//          }
//        }
//      }
//    }
//  }
//
//}
