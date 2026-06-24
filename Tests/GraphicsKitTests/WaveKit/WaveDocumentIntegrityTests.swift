import Foundation
import Testing
import WaveKit

@Suite("Wave document integrity")
struct WaveDocumentIntegrityTests {

  @Test("Adding an element reuses an existing wave identity")
  func addingElementReusesExistingWave() {
    var document = WaveDocument.original()
    let wave = document.waves[0]
    let initialWaveCount = document.waves.count

    document.addElement(.dashGap, with: wave)

    #expect(document.waves.count == initialWaveCount)
    #expect(document.drivers.contains {
      $0.elementKind == .dashGap && $0.waveID == wave.id
    })
    #expect(document.isValid)
  }

  @Test("Removing an element preserves a wave shared by another driver")
  func removingElementPreservesSharedWave() throws {
    var document = WaveDocument.original()
    let sharedWaveID = try #require(document[element: .dotX])

    document.removeElement(.dotX)

    #expect(document[element: .dotX] == nil)
    #expect(document[element: .dotHue] == sharedWaveID)
    #expect(document[waveID: sharedWaveID] != nil)
    #expect(document.isValid)
  }

  @Test("Removing an element removes its newly orphaned wave")
  func removingElementRemovesOrphanedWave() throws {
    var document = WaveDocument.original()
    let waveID = try #require(document[element: .dotRadius])

    document.removeElement(.dotRadius)

    #expect(document[element: .dotRadius] == nil)
    #expect(document[waveID: waveID] == nil)
    #expect(document.isValid)
  }

  @Test("Removing a wave also removes all of its drivers")
  func removingWaveRemovesDrivers() throws {
    var document = WaveDocument.original()
    let waveID = try #require(document[element: .dotX])

    document.removeWave(id: waveID)

    #expect(document[waveID: waveID] == nil)
    #expect(!document.drivers.contains { $0.waveID == waveID })
    #expect(document.isValid)
  }

  @Test("Validation reports dangling drivers and orphaned waves")
  func validationReportsIntegrityProblems() {
    var document = WaveDocument.original()
    let orphanedWave = ConfiguredWave(
      amplitude: 1,
      frequency: 1,
      waveform: .triangle
    )
    let missingWaveID = UUID()
    let danglingDriver = WaveDriver(
      waveID: missingWaveID,
      elementKind: .dashPhase,
      operation: .addToBase
    )
    document.waves.append(orphanedWave)
    document.drivers.append(danglingDriver)

    #expect(document.validationIssues.contains(
      .driverReferencesMissingWave(
        driverID: danglingDriver.id,
        waveID: missingWaveID
      )
    ))
    #expect(document.validationIssues.contains(
      .waveHasNoDriver(waveID: orphanedWave.id)
    ))
    #expect(!document.isValid)
  }
}
