// swift-tools-version: 6.2

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "BaseHelpers",
  platforms: [
    .iOS("17.0"),
    .macOS("14.0"),
  ],
  products: [
    .library(
      name: "BaseMacrosLibrary",
      targets: [
        "EnumMacros",
//        "Persistable",
      ]
    ),
    .executable(
      name: "BaseMacrosClient",
      targets: ["BaseMacrosClient"]
    ),
    .library(name: "ToolKit", targets: ["ToolKit"]),
    .library(name: "BaseModels", targets: ["BaseModels"]),
    .library(name: "StringShared", targets: ["StringShared"]),
    .library(name: "BaseNetworking", targets: ["BaseNetworking"]),
    .library(
      name: "BaseUI",
      targets: [
        "BaseUI",
        "GestureKit",
        "GraphicsKit",
        "LayoutKit",
        "MotionKit",
      ]
    ),
    .library(name: "CanvasKit", targets: ["CanvasKit"]),
    .library(name: "ColourKit", targets: ["ColourKit"]),
    .library(name: "CurveKit", targets: ["CurveKit"]),
    .library(name: "SharedHelpers", targets: ["SharedHelpers"]),
  ],

  // MARK: - Dependancies
  dependencies: [
    .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.0.0"),
    .package(url: "https://github.com/swiftlang/swift-syntax", from: "600.0.1"),
    .package(url: "https://github.com/mattmassicotte/nsui", from: "1.3.0"),
    .package(url: "https://github.com/evgenyneu/keychain-swift", from: "24.0.0"),
    .package(url: "https://github.com/stackotter/swift-macro-toolkit", from: "0.6.0"),
    .package(url: "https://github.com/ukushu/Ifrit", from: "3.0.0"),
    .package(url: "https://github.com/pointfreeco/swift-sharing", from: "2.7.2"),
    .package(url: "https://github.com/pointfreeco/swift-identified-collections", from: "1.1.1"),
    .package(url: "https://github.com/kean/Nuke", from: "12.8.0"),
  ],

  // MARK: - Targets

  targets: [
    .target(
      name: "BaseNetworking",
      dependencies: [
        .dep(.stringShared),
        .product(name: "KeychainSwift", package: "keychain-swift"),
      ],
    ),
    .target(
      name: "BaseUI",
      dependencies: [
        .dep(.stringShared),
        .dep(.curveKit),
        .dep(.enumMacros),
        .dep(.colourKit),
        .dep(.layoutKit),
        .dep(.graphicsKit),
        .dep(.gestureKit),
        .sharing,
        .product(name: "IfritStatic", package: "Ifrit"),
        .product(name: "NukeUI", package: "Nuke"),
      ],
    ),
    .target(
      name: "BaseModels",
      dependencies: [
        .dep(.stringShared),
        .dep(.enumMacros),
        .sharing,
        .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
      ],
    ),
    .target(
      name: "CanvasKit",
      dependencies: [
        .dep(.baseUI),
        .dep(.sharedHelpers),
        .dep(.gestureKit),
        .sharing,
      ],
    ),

    .target(
      name: "ColourKit",
      dependencies: [
        .dep(.sharedHelpers),
        .dep(.curveKit),
        .nsui,
        //        .product(name: "CasePaths", package: "swift-case-paths"),
      ],
    ),

    .target(
      name: "CurveKit",
      dependencies: [
        .dep(.sharedHelpers)
      ]
    ),

    .target(
      name: "GestureKit",
      dependencies: [
        .dep(.stringShared),
        .dep(.layoutKit),
        .dep(.curveKit),
      ]
    ),
    .target(
      name: "GraphicsKit",
      dependencies: [
        .dep(.sharedHelpers),
        .dep(.colourKit),
      ]
    ),
    .target(
      name: "LayoutKit",
      dependencies: [
        .dep(.stringShared),
        .dep(.enumMacros),
      ]
    ),

    .target(
      name: "MotionKit",
      dependencies: [
        .dep(.stringShared)
      ]
    ),
    .target(name: "SharedHelpers"),

    .target(
      name: "StringKit",
      dependencies: [
        .nsui,
        .dep(.sharedHelpers),
        .dep(.enumMacros),
      ]
    ),

    .target(
      name: "StringShared",
      dependencies: [
        .dep(.sharedHelpers),
        .dep(.stringKit),
      ],
    ),

    .target(
      name: "ToolKit",
      dependencies: [
        .dep(.enumMacros),
        .dep(.baseUI),
        .dep(.baseModels),
        .dep(.layoutKit),
        .dep(.stringKit),
        .dep(.sharedHelpers),
      ]
    ),

    // MARK: - BaseMacro targets
    .macro(
      name: "BaseMacrosImplementation",
      dependencies: [
        .dep(.sharedHelpers),
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
//        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftDiagnostics", package: "swift-syntax"),
        .product(name: "MacroToolkit", package: "swift-macro-toolkit"),
      ],
      path: .macrosSource + "/MacroImplementations",
    ),
//    .target(
//      name: "Persistable",
//      dependencies: ["BaseMacrosImplementation"],
//      path: .macrosSource + "/MacroDeclarations",
//    ),
    .target(
      name: "EnumMacros",
      dependencies: ["BaseMacrosImplementation"],
      path: .macrosSource + "/MacroDeclarations",
    ),
    .executableTarget(
      name: "BaseMacrosClient",
      dependencies: [
        "EnumMacros",
//        "Persistable",
      ],
      path: .macrosSource + "/BaseMacrosClient",
    ),
    
//      .testTarget(
//        name: "MacroTests",
//        dependencies: [
//          "BaseMacrosImplementation",
//          .product(
//            name: "SwiftSyntaxMacrosTestSupport",
//            package: "swift-syntax"
//          ),
//        ]
//      ),

  ],
)
// MARK: - Convenient type-safe extensions
extension Target.Dependency {
  static func dep(_ baseModule: BaseModule) -> Self {
    .target(name: baseModule.name)
  }
  static var sharing: Self {
    .product(name: "Sharing", package: "swift-sharing")
  }
  static var nsui: Self {
    .product(name: "NSUI", package: "nsui")
  }
}
extension String {
  static var macrosSource: String { "Sources/BaseMacrosLibrary" }
}

//for target in package.targets {
//  guard target.name != BaseModule.enumMacros.name,
//    target.name != BaseModule.persistable.name
//  else { continue }
//
//  var settings = target.swiftSettings ?? []
//  settings.append(.defaultIsolation(MainActor.self))
//  target.swiftSettings = settings
//}

/// List of common modules for convenience
enum BaseModule {

  case enumMacros
//  case persistable
  case networking
  case baseUI
  case baseModels
  case canvasKit
  case colourKit
  case curveKit
  case gestureKit
  case graphicsKit
  case layoutKit
  case motionKit
  case sharedHelpers
  case stringKit

  /// Export modules
  case toolKit
  case stringShared

  var name: String {
    switch self {
      case .enumMacros: "EnumMacros"
//      case .persistable: "Persistable"
      case .networking: "BaseNetworking"
      case .baseUI: "BaseUI"
      case .baseModels: "BaseModels"
      case .canvasKit: "CanvasKit"
      case .colourKit: "ColourKit"
      case .curveKit: "CurveKit"
      case .gestureKit: "GestureKit"
      case .graphicsKit: "GraphicsKit"
      case .layoutKit: "LayoutKit"
      case .motionKit: "MotionKit"
      case .sharedHelpers: "SharedHelpers"
      case .stringKit: "StringKit"
      case .toolKit: "ToolKit"
      case .stringShared: "StringShared"
    }
  }
}
