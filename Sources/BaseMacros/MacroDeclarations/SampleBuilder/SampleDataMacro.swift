//
//  SampleDataMacro.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/10/2025.
//

import BasePrimitives

// Full credit to Pedro Rojas and project authors for
// this SampleData macro
// https://github.com/pitt500/SwiftAndTipsMacros?tab=readme-ov-file#samplebuilder
//
// This source file is part of SwiftAndTipsMacros
// Copyright (c) 2023 Pedro Rojas and project authors
// Licensed under MIT License
@attached(member, names: named(sample))
public macro SampleBuilder(
  numberOfItems: Int,
  dataGeneratorType: DataGeneratorType
) = #externalMacro(module: "BaseMacrosImplementation", type: "SampleBuilderMacro")

@attached(peer)
public macro SampleBuilderItem(
  category: SampleBuilderItemCategory
) = #externalMacro(module: "BaseMacrosImplementation", type: "SampleBuilderItemMacro")
