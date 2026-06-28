//
//  CaseEquality.swift
//  ViewKit
//
//  Created by Dave Coleman on 20/1/2026.
//

import Foundation

/// This code from Swift forum user `stephencelis`
/// https://forums.swift.org/t/comparing-enum-cases-while-ignoring-associated-values/15922/26
public func areCasesEqual<T>(_ lhs: T, _ rhs: T) -> Bool {
  guard let lhsTag = enumTag(lhs),
    let rhsTag = enumTag(rhs)
  else { return false }
  return lhsTag == rhsTag
}

func enumTag<Case>(_ `case`: Case) -> UInt32? {
  let metadataPtr = unsafeBitCast(type(of: `case`), to: UnsafeRawPointer.self)
  let kind = metadataPtr.load(as: Int.self)
  let isEnumOrOptional = kind == 0x201 || kind == 0x202
  guard isEnumOrOptional else { return nil }
  let vwtPtr = (metadataPtr - MemoryLayout<UnsafeRawPointer>.size).load(as: UnsafeRawPointer.self)
  let vwt = vwtPtr.load(as: EnumValueWitnessTable.self)
  return withUnsafePointer(to: `case`) { vwt.getEnumTag($0, metadataPtr) }
}

private struct EnumValueWitnessTable {
  let f1, f2, f3, f4, f5, f6, f7, f8: UnsafeRawPointer
  let f9, f10: Int
  let f11, f12: UInt32
  let getEnumTag: @convention(c) (UnsafeRawPointer, UnsafeRawPointer) -> UInt32
  let f13, f14: UnsafeRawPointer
}
