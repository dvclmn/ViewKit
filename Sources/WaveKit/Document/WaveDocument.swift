//
//  WaveDocument.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/2/2026.
//

import BaseTools
import ColourTools
import CoreTools
import Foundation
import GraphicsKit
import ViewTools

public typealias WaveElements = [WaveVisualElement.Kind: WaveVisualElement]
public struct WaveDocument: Codable, Sendable, Equatable {

  public var waves: IdentifiedList<ConfiguredWave>
  public var settings: WaveRenderSettings

  /// The channels define which elements are driven by which waves (and how).
  /// binds wave→element
  public var drivers: [WaveDriver]

  public init(
    waves: IdentifiedList<ConfiguredWave>,
    settings: WaveRenderSettings,
    drivers: [WaveDriver],
  ) {
    self.waves = waves
    self.settings = settings
    self.drivers = drivers
  }

  /// Convenience initializer to allow passing a plain array.
  public init(
    waves: [ConfiguredWave],
    settings: WaveRenderSettings,
    drivers: [WaveDriver],
  ) {
    self.init(waves: IdentifiedList(waves), settings: settings, drivers: drivers)
  }
}

extension WaveDocument {
  public mutating func addElement(
    _ kind: WaveVisualElement.Kind,
    with wave: ConfiguredWave = .waveHExample,
  ) {
    let newDriver = WaveDriver(
      waveID: wave.id,
      elementKind: kind,
      operation: kind.operation,
    )
    waves.append(wave)
    drivers.append(newDriver)
  }

  /// Compatibility overload for the earlier API. Element base values are
  /// derived by the renderer from the element kind, render settings, and view
  /// geometry; `WaveDocument` has no independent base-value storage.
  @available(
    *,
    deprecated,
    message: "baseValue was never stored; use addElement(_:with:)."
  )
  public mutating func addElement(
    _ kind: WaveVisualElement.Kind,
    baseValue: Double?,
    with wave: ConfiguredWave = .waveHExample,
  ) {
    addElement(kind, with: wave)
  }

  /// Removes every driver for an element and any wave left unreferenced by
  /// that removal. Waves shared with another element remain in the document.
  public mutating func removeElement(_ kind: WaveVisualElement.Kind) {
    let candidateWaveIDs = Set(
      drivers.lazy
        .filter { $0.elementKind == kind }
        .map(\.waveID)
    )

    drivers.removeAll { $0.elementKind == kind }

    for waveID in candidateWaveIDs
    where !drivers.contains(where: { $0.waveID == waveID }) {
      waves.remove(id: waveID)
    }
  }

  /// Removes a wave and every driver that references it.
  public mutating func removeWave(id waveID: ConfiguredWave.ID) {
    waves.remove(id: waveID)
    drivers.removeAll { $0.waveID == waveID }
  }

  public subscript(waveID waveID: ConfiguredWave.ID) -> ConfiguredWave? {
    get { waves[id: waveID] }
    set { waves[id: waveID] = newValue }
  }

  public subscript(element elementKind: WaveVisualElement.Kind) -> ConfiguredWave.ID? {
    get {
      let driver = drivers.first { driver in
        driver.elementKind == elementKind
      }
      return driver?.waveID
    }
  }

  public static func original(
    waveH: ConfiguredWave = .waveHExample,
    waveV: ConfiguredWave = .waveVExample,
    waveR: ConfiguredWave = .waveRExample,
    style: WaveStyle = .originalExample,
    sampleCount: Int = 20,
    placement: WavePlacement = .vertical,
    interpolation: CurveInterpolation = .linear,
  ) -> Self {
    let settings = WaveRenderSettings(
      style: style,
      blendMode: .add,
      placement: placement,
      sampleCount: sampleCount,
      interpolation: interpolation,
    )

    let drivers: [WaveDriver] = [
      .make(.dotX, waveID: waveV.id),
      .make(.dotY, waveID: waveH.id),
      .make(.dotRadius, waveID: waveR.id),
      .make(.dotHue, waveID: waveV.id),
    ]

    return .init(
      waves: IdentifiedList([waveH, waveV, waveR]),
      settings: settings,
      drivers: drivers,
    )
  }
}

extension WaveDocument {
  public enum ValidationIssue: Sendable, Hashable {
    case driverReferencesMissingWave(
      driverID: WaveDriver.ID,
      waveID: ConfiguredWave.ID
    )
    case waveHasNoDriver(waveID: ConfiguredWave.ID)
  }

  /// Reports referential-integrity problems without mutating decoded or
  /// externally constructed documents.
  public var validationIssues: [ValidationIssue] {
    let waveIDs = Set(waves.map(\.id))
    let referencedWaveIDs = Set(drivers.map(\.waveID))
    var issues = drivers.compactMap { driver -> ValidationIssue? in
      guard !waveIDs.contains(driver.waveID) else { return nil }
      return .driverReferencesMissingWave(
        driverID: driver.id,
        waveID: driver.waveID
      )
    }

    issues.append(
      contentsOf: waves.compactMap { wave -> ValidationIssue? in
        guard !referencedWaveIDs.contains(wave.id) else { return nil }
        return .waveHasNoDriver(waveID: wave.id)
      }
    )
    return issues
  }

  public var isValid: Bool { validationIssues.isEmpty }
}
