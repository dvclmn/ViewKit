//
//  ModulatorKind.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

/// The parameters on ``WaveConfig`` that are modulated
public enum ModulatorKind: String, Codable {
  case horizontal
  case vertical // Previously 'spacing' wave
  case dotRadius
}

extension ModulatorKind {
  private var configPath: PartialKeyPath<WaveConfig> {
    switch self {
      case .horizontal: \.horizontalWave
      case .vertical: \.verticalWave
      case .dotRadius: \.radiusWave
    }
  }
  
  public func isActive(in config: WaveConfig) -> Bool {
    
  }
}
