//
//  Dimensions.swift
//  BoxCore
//
//  Created by Dave Coleman on 15/9/2024.
//

//extension Box {
//
//  public struct Dimensions {
//    var width: DimensionType
//    var height: DimensionType
//
//    init(_ width: DimensionType, _ height: DimensionType) {
//      self.width = width
//      self.height = height
//    }
//
//    init(_ width: Int, _ height: Int) {
//      self.width = .fixed(.init(width))
//      self.height = .fixed(.init(height))
//    }
//  }
//
//  public enum DimensionType {
//    case fixed(Int)
//    case repeatable(min: Int, max: Int?)
//
//    var fixedValue: Int? {
//      switch self {
//        case .fixed(let value):
//          return value
//        case .repeatable:
//          return nil
//      }
//    }
//  }
//}
