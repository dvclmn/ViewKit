// swift-tools-version: 6.3

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "BaseHelpers",
  platforms: [
    .iOS("17.0"),
    .macOS("14.0"),
  ],
  products: [

    /// Helper Libraries
    .library(name: "BaseNetworking", targets: ["BaseNetworking"]),

    .library(
      name: "BasePrimitives",
      targets: ["BasePrimitives"],
    ),

    .library(
      name: "BaseUI",
      targets: [
        "BaseUI",
        "LayoutKit",
        "ComponentKit",
      ],
    ),

    .library(
      name: "GraphicsKit",
      targets: [
        "GraphicsKit",
        "MotionKit",
      ],
    ),

    .library(
      name: "Wrecktangle",
      targets: ["Wrecktangle"],
    ),

    /// Export-only libraries
    .library(name: "ToolKit", targets: ["ToolKit"]),
  ],

  // MARK: - Dependancies
  dependencies: [
    .package(url: "https://github.com/evgenyneu/keychain-swift", from: "24.0.0"),
    .package(url: "https://github.com/pointfreeco/swift-case-paths", branch: "1.7.2"),
    .package(url: "https://github.com/SwiftyLab/MetaCodable", from: "1.6.0"),
    .package(url: "https://github.com/dvclmn/InteractionKit", branch: "main"),
    .package(url: "https://github.com/dvclmn/BaseMacros", branch: "main"),
  ],

  // MARK: - Targets
  targets: [
    .target(
      name: "BaseNetworking",
      dependencies: [
        .module(.basePrimitives),
        .extDependency(.keychainSwift),
      ],
    ),

    .target(
      name: "BasePrimitives",
      dependencies: [
        .extDependency(.enumMacros),
        .extDependency(.casePaths),
        .extDependency(.interactionKit),
      ],
      resources: [
        .process("Resources/Assets.xcassets"),
        .process("Resources/Fonts"),
      ],
    ),

    .target(
      name: "BaseUI",
      dependencies: [
        .module(.basePrimitives),
        .module(.layoutKit),
        .extDependency(.enumMacros),
        .extDependency(.interactionKit),
      ],
    ),

    /// Can't think of a better name for this, but `ComponentKit` exists purely
    /// to avoid burdening `BaseUI` with `CasePaths` and `GraphicsKit`
    .target(
      name: "ComponentKit",
      dependencies: [
        .module(.baseUI),
        .module(.basePrimitives),
        .module(.graphicsKit),
        .module(.layoutKit),
        .extDependency(.casePaths),
      ],
    ),

    .target(
      name: "GraphicsKit",
      dependencies: [
        .module(.basePrimitives),
        .extDependency(.enumMacros),
        .extDependency(.casePaths),
        .extDependency(.interactionKit),
      ],
      resources: [
        .process("Shaders/MetalShaders")
      ],
    ),

    .target(
      name: "LayoutKit",
      dependencies: [
        .module(.basePrimitives),
        .extDependency(.interactionKit),
        .extDependency(.enumMacros),
      ],
    ),

    .target(
      name: "MotionKit",
      dependencies: [
        .module(.basePrimitives)
      ],
    ),

    .target(
      name: "Wrecktangle",
      dependencies: [
        .module(.basePrimitives)
      ],
    ),

    // MARK: - Forwarding modules

    .target(
      name: "ToolKit",
      dependencies: [
        .module(.basePrimitives),
        .module(.baseUI),
        .module(.graphicsKit),
      ],
    ),

    // MARK: - Test targets

    .testTarget(
      name: "BasePrimitivesTests",
      dependencies: [.module(.basePrimitives)],
      exclude: ["BasePrimitives.xctestplan"],
    ),
  ],
)
// MARK: - Type-safe factory helpers
extension Target.Dependency {
  static func module(_ name: InternalModule) -> Self {
    .target(name: name.name)
  }

  static func extDependency(_ dependency: ExternalDependency) -> Self {
    .product(
      name: dependency.reference.0,
      package: dependency.reference.1 ?? dependency.reference.0,
    )
  }

}

enum ExternalDependency {
  case enumMacros
  case casePaths
  case interactionKit
  case keychainSwift
  case macroToolkit

  var reference: (String, String?) {
    switch self {
      case .enumMacros: ("BaseMacros", nil)
      case .casePaths: ("CasePaths", "swift-case-paths")
      case .interactionKit: ("InteractionKit", nil)
      case .keychainSwift: ("KeychainSwift", "keychain-swift")
      case .macroToolkit: ("MacroToolkit", "swift-macro-toolkit")
    }
  }
}

enum InternalModule {
  case networking
  case basePrimitives
  case baseUI
  case componentKit
  case graphicsKit
  case layoutKit
  case motionKit
  case wrecktangle

  /// Export-only modules
  case toolKit

  var name: String {
    switch self {
      case .networking: "BaseNetworking"
      case .basePrimitives: "BasePrimitives"
      case .baseUI: "BaseUI"
      case .componentKit: "ComponentKit"
      case .graphicsKit: "GraphicsKit"
      case .layoutKit: "LayoutKit"
      case .motionKit: "MotionKit"
      case .wrecktangle: "Wrecktangle"

      /// Export-only
      case .toolKit: "ToolKit"

    }
  }
}
