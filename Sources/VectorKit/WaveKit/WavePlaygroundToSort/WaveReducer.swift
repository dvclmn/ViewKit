//
//  WaveReducer.swift
//  AnimationVisualiser
//
//  Created by Dave Coleman on 8/11/2024.
//

//import SwiftUI
//import Sharing
//
//import OrderedCollections
//
//
//struct WaveReducer: Equatable {
//  
//  @Shared(.document) var document: AnimationDocument = .init()
//  
//  var waveStates: WaveStates = EffectKey.defaultWaveStates
//  
//  var hoveredProperty: AnimatedEffect? = nil
//  
//  let debugMode = false
//  
//  var activeProperties: OrderedSet<EffectKey> {
//    OrderedSet(
//      document.configurations.keys.sorted { $0.effect.name < $1.effect.name }
//    )
//  }
//  
//  var activePropertiesGrouped: [AnimatedEffect: [EffectKey]] {
//    Dictionary(
//      grouping: document.configurations.keys,
//      by: { $0.effect }
//    )
//  }
//
//}
//
//extension WaveReducer {
//  
//  /// Convenient way to access configuration parameters from views
//  func parameterValue(
//    for parameter: WaveParameter,
//    key: EffectKey
//  ) -> Double {
//    self.document.configurations[key]?.value(for: parameter) ?? 0.0
//  }
//
//  func updateConfiguration(
//    value: Double,
//    parameter: WaveParameter,
//    property: EffectKey
//  ) {
//    
//    var config: WaveConfiguration = document.configurations[property] ?? WaveConfiguration.default
//    
//    config[keyPath: parameter.keyPath] = value
//    
//    $document.withLock { $0.configurations[property] = config }
//    
//  }
//  
//}
