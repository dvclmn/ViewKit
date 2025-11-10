//
//  Printing.swift
//  Helpers
//
//  Created by Dave Coleman on 21/8/2024.
//

import Foundation

extension Dictionary where Key: CustomStringConvertible, Value: CustomStringConvertible {
  public var prettyString: String {
    let jsonCompatible = self.reduce(into: [String: String]()) { result, pair in
      result[pair.key.description] = pair.value.description
    }
    
    guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonCompatible, options: .prettyPrinted),
          let jsonString = String(data: jsonData, encoding: .utf8)
    else { return String(describing: self) }
    
    return jsonString
  }
}

//extension Dictionary where Self.Key: CustomStringConvertible, Self.Value: CustomStringConvertible {
//
//  public var prettyString: String {
//    guard let data = try? JSONDecoder
//    
//    guard
//      let jsonData = try? JSONSerialization.data(
//        withJSONObject: self,
//        options: .prettyPrinted
//      ),
//      let jsonString = String(data: jsonData, encoding: .utf8)
//    else { return String(self.description) }
//
//    return jsonString
//  }
//}
