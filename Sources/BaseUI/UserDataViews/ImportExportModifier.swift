//
//  ImportExportModifier.swift
//  ViewKit
//
//  Created by Dave Coleman on 6/2/2026.
//

import CoreTools
// import BaseTools
import SwiftUI
import ViewKitCore
import ViewTools

/// Adds JSON import and export toolbar actions for a ready user data store.
///
/// Apply this modifier from content that is already gated by ``UserDataView`` or
/// an equivalent readiness check. The exporter reads `store.userData()`, which
/// intentionally traps if the store has not reached `UserDataState.ready`.
public struct ImportExportModifier<Store: UserDataHandler>: ViewModifier
where Store.Value: Transferable & Codable {

  @Environment(\.popup) private var popup

  @State private var isImporting: Bool = false
  @State private var isExporting: Bool = false

  @Bindable var store: Store
  public func body(content: Content) -> some View {

    content
      .fileExporter(
        isPresented: $isExporting,
        item: store.userData(),
        onCompletion: { result in
          switch result {
            case .success(let url):
              popup?.showPopup(
                .make(
                  "Successfully exported preset",
                  actions: PopupAction(
                    title: "See in Finder",
                    action: {
                      OpenInFinder.open(url)
                    },
                  ),
                )
              )

            case .failure(let error):
              popup?.showPopup("Failed to export preset: \(error)")
          }
        },
      )

      .fileImporter(
        isPresented: $isImporting,
        allowedContentTypes: [.json],
        onCompletion: { result in
          do {
            let importedValue = try ImportHandler.loadSecurityScoped(
              result: result,
              asType: Store.Value.self,
            )
            store.setValue(action: .withUndo(action: "Load Preset")) {
              $0 = importedValue
            }

          } catch {
            popup?.showPopup("File import error: \(error)")
          }
        },
      )

      .toolbar {
        ToolbarItemGroup {
          Button {
            isExporting = true
          } label: {
            Label("Save Preset", systemImage: Icons.plus.icon)
          }

          Button {
            isImporting = true
          } label: {
            Label("Load Preset", systemImage: "folder.badge.gearshape")
          }
        }
      }
  }
}
extension View {
  public func importExport<S>(_ store: S) -> some View
  where S: UserDataHandler, S.Value: Transferable & Codable {
    self.modifier(ImportExportModifier(store: store))
  }
}
