//
//  Part+Corner.swift
//  BoxCore
//
//  Created by Dave Coleman on 11/9/2024.
//

import Foundation

public extension Box {

  struct BoxPart {
    public var content: MultilineString
    public var type: PartType
    
    public init(content: MultilineString, type: PartType) {
      self.content = content
      self.type = type
    }
  }
}

public extension Box.BoxPart {
  
  var width: Int {
    content.width
  }
  
  var height: Int {
    content.height
  }
  
  var columns: Int {
    self.width
  }
  
  var rows: Int {
    self.height
  }
  

}
