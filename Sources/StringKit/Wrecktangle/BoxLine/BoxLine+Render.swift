//
//  BoxLine+Render.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

extension Box.Line {
  func render(width: Int) -> String {
    
    /// Width refers to total available; subtract leading/trailing widths
    let bodyWidth = width - (leading.width + trailing.width)
    let bodyRendered = body.render(toWidth: bodyWidth)
    return leading.render() + bodyRendered + trailing.render()
  }
}

//extension Box.Line {
//
//  public func render() -> String {
//
//    let renderedContent: StringStack
//    renderedContent = StringStack(content.rawContent)
//
//    let joinedContent = leadingCap.content + renderedContent + trailingCap.content
//
//    return joinedContent.string
//
//  }
//
//}
