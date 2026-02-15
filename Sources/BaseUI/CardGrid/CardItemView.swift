//
//  CardItemView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/2/2026.
//

import CoreTools
import SwiftUI

extension CardGrid {

  struct ItemView: View {
    //    @Environment(\.isEmphasised) private var isEmphasised

    @State private var isHovering: Bool = false
    let item: Item
    //    let data: [Item]
    let cardSize: CGSize
    @ViewBuilder var content: CardItem

    var body: some View {

      if #available(macOS 15, iOS 18, *) {

        Group(subviews: content(item)) { subviewCollection in
          ForEach(subviewCollection) { subview in

            subview
            //            ItemSubView(
            //              item: item,
            //              cardSize: cardSize,
            //              content: conte
            //            ) { item, isHovering in
            //
            //            }
          }
        }

        //        }  // END for each

      } else {
        content(item)
        //        ForEach(data) { item in
        //          ItemSubView(
        //            item: item,
        //            cardSize: cardSize,
        //            content: content
        //              //                subview: subview
        //              //                content: content
        //          )
        //        }
      }

      //
      //    content(item, isHovering)

      //        }

      //      }

    }
  }
}
