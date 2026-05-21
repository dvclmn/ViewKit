//
//  AppInfo.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/3/2026.
//

import SwiftUI

public enum AppInfo {
  public static var copyright: String {
    let calendar = Calendar.current
    let year = calendar.component(.year, from: Date())
    return "􀀈 \(year) Dave Coleman"
  }

  public static var appVersionAndBuild: String {
    //    let dict = Bundle.main.infoDictionary
    let version = infoDict("CFBundleShortVersionString") ?? "N/A"
    let build = infoDict("CFBundleVersion") ?? "N/A"
    return "Version \(version) (\(build))"
  }

  public static var devWebsite: URL { URL(string: "https://dvclmn.com/")! }
  public static var devWebsiteDisplay: String { "dvclmn.com" }

  public static var appDisplayName: String {

    /// Prefer CFBundleDisplayName, fall back to CFBundleName, then bundle name, then product name
    if let displayName = bundleObject(for: "CFBundleDisplayName"), !displayName.isEmpty {
      return displayName
    }

    if let name = bundleObject(for: "CFBundleName"), !name.isEmpty {
      return name
    }

    if let bundleName = infoDict("CFBundleName"), !bundleName.isEmpty {
      return bundleName
    }
    return ProcessInfo.processInfo.processName
  }

  @MainActor
  public static var appIcon: some View {
    if let icon = NSApplication.shared.applicationIconImage {
      Image(nsImage: icon)
        .resizable()
        .scaledToFit()
    } else {
      Image(systemName: "app.dashed")  // app.fill
        .resizable()
        .scaledToFit()
    }
  }

}

extension AppInfo {
  fileprivate static func bundleObject(for key: String) -> String? {
    Bundle.main.object(forInfoDictionaryKey: key) as? String
  }

  fileprivate static func infoDict(_ key: String) -> String? {
    Bundle.main.infoDictionary?[key] as? String
  }

}
