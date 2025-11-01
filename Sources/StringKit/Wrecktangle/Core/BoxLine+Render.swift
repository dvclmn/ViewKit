//
//  BoxLine+Render.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

extension Box.Line {

  public func render() -> String {

    let renderedContent: StringStack
    renderedContent = StringStack(content.rawContent)

    let joinedContent = leadingCap.content + renderedContent + trailingCap.content

    return joinedContent.string

  }

}
