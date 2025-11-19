//
//  PlatformCodable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/10/2025.
//

//
//// Credit to Natalia Panferova and Matthaus Woolard of
//// https://nilcoalescing.com/blog/EncodeAndDecodeSwiftUIColor/
//
//import SwiftUI
//import NSUI
//
///// For when dealing only with Apple platforms
///// The encoded color will be decoded on one of those platforms
//public protocol PlatformColourCodable: Codable {
//  var colour: Color { get }
//}
//
//extension PlatformColourCodable {
//  
//  public func encode() throws -> Data {
//    //  public func encodeAsPlatformColour(_ colour: Color) throws -> Data {
//    let platformColor = NSUIColor(colour)
//    return try NSKeyedArchiver.archivedData(
//      withRootObject: platformColor,
//      requiringSecureCoding: true
//    )
//  }
//  
//  public func decode(from data: Data) throws -> Color {
//    guard
//      let platformColor = try NSKeyedUnarchiver.unarchivedObject(
//        ofClass: NSUIColor.self,
//        from: data
//      )
//    else { throw DecodingError.wrongType }
//    return Color(nsuiColor: platformColor)
//  }
//}
