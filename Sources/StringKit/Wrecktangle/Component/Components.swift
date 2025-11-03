//
//  Components.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/11/2025.
//

import Foundation

extension Box {
  public struct Top: Component, Codable {
    public init() {}
    public func makeLines(using engine: Box.Engine) -> [Box.Line] {
      [engine.structureLine(type: .top)]
    }
  }

  public struct Divider: Component, Codable {
    public init() {}
    public func makeLines(using engine: Box.Engine) -> [Box.Line] {
      [engine.structureLine(type: .divider)]
    }
  }

  public struct Bottom: Component, Codable {
    public init() {}
    public func makeLines(using engine: Box.Engine) -> [Box.Line] {
      [engine.structureLine(type: .bottom)]
    }
  }

  public struct Text: Component, Codable {
    let content: String
    public init(_ content: String) { self.content = content }

    public func makeLines(using engine: Box.Engine) -> [Box.Line] {
      engine.textLines(content)
    }
  }

  public struct Header: Component, Codable {
    let text: String
    public init(_ text: String) { self.text = text }

    public func makeLines(using engine: Box.Engine) -> [Box.Line] {
      [engine.structureLine(type: .top)]
      + engine.textLines(text)
      + [engine.structureLine(type: .divider)]
      
    }
  }
  
  /// Manual Codable conformance is necessary to encode/decode heterogeneous Component types in 'items'.
  
}

//extension Box {
//  public struct List: Component, Codable {
//    let items: [Component]
//    
//    public init(@BoxBuilder content: () -> [Component]) {
//      self.items = content()
//    }
//    
//    //    private enum ComponentType: String, Codable {
//    //      case top, divider, bottom, text, header, list
//    //    }
//    //
//    //    public func encode(to encoder: Encoder) throws {
//    //      var container = encoder.unkeyedContainer()
//    //      for item in items {
//    //        var itemContainer = container.nestedContainer(keyedBy: CodingKeys.self)
//    //        switch item {
//    //        case let top as Top:
//    //          try itemContainer.encode(ComponentType.top, forKey: .type)
//    //          try itemContainer.encode(top, forKey: .payload)
//    //        case let divider as Divider:
//    //          try itemContainer.encode(ComponentType.divider, forKey: .type)
//    //          try itemContainer.encode(divider, forKey: .payload)
//    //        case let bottom as Bottom:
//    //          try itemContainer.encode(ComponentType.bottom, forKey: .type)
//    //          try itemContainer.encode(bottom, forKey: .payload)
//    //        case let text as Text:
//    //          try itemContainer.encode(ComponentType.text, forKey: .type)
//    //          try itemContainer.encode(text, forKey: .payload)
//    //        case let header as Header:
//    //          try itemContainer.encode(ComponentType.header, forKey: .type)
//    //          try itemContainer.encode(header, forKey: .payload)
//    //        case let list as List:
//    //          try itemContainer.encode(ComponentType.list, forKey: .type)
//    //          try itemContainer.encode(list, forKey: .payload)
//    //        default:
//    //          let context = EncodingError.Context(codingPath: container.codingPath, debugDescription: "Unsupported component type: \(type(of: item))")
//    //          throw EncodingError.invalidValue(item, context)
//    //        }
//    //      }
//    //    }
//    
//    //    public init(from decoder: Decoder) throws {
//    //      var container = try decoder.unkeyedContainer()
//    //      var items = [Component]()
//    //
//    //      while !container.isAtEnd {
//    //        let itemContainer = try container.nestedContainer(keyedBy: CodingKeys.self)
//    //        let type = try itemContainer.decode(ComponentType.self, forKey: .type)
//    //        switch type {
//    //        case .top:
//    //          let top = try itemContainer.decode(Top.self, forKey: .payload)
//    //          items.append(top)
//    //        case .divider:
//    //          let divider = try itemContainer.decode(Divider.self, forKey: .payload)
//    //          items.append(divider)
//    //        case .bottom:
//    //          let bottom = try itemContainer.decode(Bottom.self, forKey: .payload)
//    //          items.append(bottom)
//    //        case .text:
//    //          let text = try itemContainer.decode(Text.self, forKey: .payload)
//    //          items.append(text)
//    //        case .header:
//    //          let header = try itemContainer.decode(Header.self, forKey: .payload)
//    //          items.append(header)
//    //        case .list:
//    //          let list = try itemContainer.decode(List.self, forKey: .payload)
//    //          items.append(list)
//    //        }
//    //      }
//    //
//    //      self.items = items
//    //    }
//    
//    //    private enum CodingKeys: String, CodingKey {
//    //      case type
//    //      case payload
//    //    }
//    //
//    public func makeLines(using engine: Box.Engine) -> [Box.Line] {
//      items.flatMap { component in
//        component.makeLines(using: engine)
//      }
//    }
//  }
//}
//
