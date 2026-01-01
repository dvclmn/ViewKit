//
//  WidthCounterStyle.swift
//  BoxCore
//
//  Created by Dave Coleman on 29/8/2024.
//

import Foundation
import SwiftUI

public struct WidthCounter {
  let width: Int
  public init(width: Int) {
    self.width = width
  }

  public enum Style: Sendable {
    case ruler
    case digits
  }

  public func widthCounter(
    //    _ width: Int,
    style: Style
  ) -> AttributedString {

    var result = AttributedString()

    switch style {

      case .digits:

        let fullOutput = self.generateDigitCounter()
        result.append(fullOutput.tens, addsLineBreak: true)

        /// Specify `false` here so we're not left with a trailing line break
        result.append(fullOutput.ones, addsLineBreak: false)

      case .ruler:

        let compactOutput = self.generateCompactCounter()

        result.append(compactOutput, addsLineBreak: false)
        result.addLineBreak()

        let pattern = String.pattern(totalCount: width) {
          character("|")
          repeating(".", count: 4)
          character("╷")
          repeating(".", count: 4)
        }

        result.append(
          pattern, addsLineBreak: false
        )
        result.addLineBreak()

    }

    return result
  }

}

struct WidthCounterView: View {

  var body: some View {

    VStack(spacing: 60) {
      Text(counter.widthCounter(style: .ruler))
      Text(counter.widthCounter(style: .digits))
    }
    .textSelection(.enabled)
    .monospaced()
    .frame(width: 400, height: 600)
    .background(.black.opacity(0.6))
  }
  private var counter: WidthCounter {
    WidthCounter(width: 38)
  }
}


#if DEBUG
#Preview {
  WidthCounterView()
}

#endif
