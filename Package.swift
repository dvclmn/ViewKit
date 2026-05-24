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
    .library(name: "BaseNetworking", targets: ["BaseNetworking"]),

    .library(
      name: "BaseTools",
      targets: ["BaseTools"],
    ),

    .library(
      name: "BaseUI",
      targets: [
        "BaseUI",
        "LayoutKit",
      ],
    ),

    .library(
      name: "GraphicsKit",
      targets: [
        "GraphicsKit",
        "MotionKit",
      ],
    ),
  ],

  // MARK: - Dependancies
  dependencies: [
    .package(url: "https://github.com/evgenyneu/keychain-swift", from: "24.0.0"),
    .package(url: "https://github.com/pointfreeco/swift-case-paths", branch: "1.7.2"),
    .package(url: "https://github.com/SwiftyLab/MetaCodable", from: "1.6.0"),
    .package(url: "https://github.com/dvclmn/BaseMacros", branch: "main"),
    .package(path: "../../ToolKit"),
  ],

  // MARK: - Targets
  targets: [
    .target(
      name: "BaseNetworking",
      dependencies: [
        .module(.baseTools),
        .extDependency(.coreTools),
        .extDependency(.keychainSwift),
      ],
    ),

    .target(
      name: "BaseTools",
      dependencies: [
        .extDependency(.enumMacros),
        .extDependency(.casePaths),
        .extDependency(.coreTools),
        .extDependency(.viewTools),
      ],
    ),

    .target(
      name: "BaseUI",
      dependencies: [
        .module(.layoutKit),
        .extDependency(.coreTools),
        .extDependency(.viewTools),
        .module(.baseTools),
        .module(.graphicsKit),
        .extDependency(.casePaths),
        .extDependency(.enumMacros),
      ],
    ),

    .target(
      name: "GraphicsKit",
      dependencies: [
        .module(.baseTools),
        .extDependency(.coreTools),
        .extDependency(.viewTools),
        .extDependency(.enumMacros),
        .extDependency(.casePaths),
      ],
      resources: [
        .process("Shaders/MetalShaders")
      ],
    ),

    .target(
      name: "LayoutKit",
      dependencies: [
        .extDependency(.coreTools),
        .extDependency(.viewTools),
        .module(.baseTools),
        .extDependency(.enumMacros),
      ],
    ),

    .target(
      name: "MotionKit",
      dependencies: [
        .extDependency(.coreTools),
        .extDependency(.viewTools),
        .module(.baseTools),
      ],
    ),

  ],
)

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
  case coreTools
  case viewTools
  case enumMacros
  case casePaths
  case keychainSwift
  case macroToolkit

  var reference: (String, String?) {
    switch self {
      case .viewTools: ("ViewTools", "ToolKit")
      case .coreTools: ("CoreTools", "ToolKit")
      case .enumMacros: ("BaseMacros", nil)
      case .casePaths: ("CasePaths", "swift-case-paths")
      case .keychainSwift: ("KeychainSwift", "keychain-swift")
      case .macroToolkit: ("MacroToolkit", "swift-macro-toolkit")
    }
  }
}

enum InternalModule {
  case networking
  case baseTools
  case baseUI
  case graphicsKit
  case layoutKit
  case motionKit

  var name: String {
    switch self {
      case .networking: "BaseNetworking"
      case .baseTools: "BaseTools"
      case .baseUI: "BaseUI"
      case .graphicsKit: "GraphicsKit"
      case .layoutKit: "LayoutKit"
      case .motionKit: "MotionKit"
    }
  }
}
