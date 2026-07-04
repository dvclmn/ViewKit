// swift-tools-version: 6.3

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "ViewKit",
  platforms: [
    .iOS(.v17),
    .macOS(.v14),
  ],
  // MARK: - Libraries
  products: [
    .library(
      name: "BaseUI",
      targets: ["BaseUI", "ViewKitCore"],
    ),

    .library(
      name: "GraphicsKit",
      targets: ["GraphicsKit", "MotionKit"],
    ),
  ],

  // MARK: - Dependancies
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-case-paths", branch: "1.7.3"),
    .package(url: "https://github.com/dvclmn/EnumMacros", branch: "main"),
    .package(url: "https://github.com/dvclmn/ToolKit", .upToNextMinor(from: "0.3.0")),
    .package(url: "https://github.com/dvclmn/VectorKit", branch: "main"),
  ],

  // MARK: - Targets
  targets: [

    .target(
      name: "BaseUI",
      dependencies: [
        .module(.viewKitCore),
        .extDependency(.coreTools),
        .extDependency(.stringTools),
        .extDependency(.viewTools),
        .extDependency(.colourTools),
        .module(.graphicsKit),
        .extDependency(.casePaths),
        .extDependency(.enumMacros),
      ],
    ),

    .target(
      name: "ViewKitCore",
      dependencies: [
        .extDependency(.coreTools),
        .extDependency(.stringTools),
        .extDependency(.viewTools),
        .extDependency(.enumMacros),
        .extDependency(.casePaths),
      ],
    ),

    .target(
      name: "GraphicsKit",
      dependencies: [
        .module(.viewKitCore),
        .extDependency(.coreTools),
        .extDependency(.stringTools),
        .extDependency(.viewTools),
        .extDependency(.vectorKit),
        .extDependency(.enumMacros),
        .extDependency(.casePaths),
      ],
      resources: [
        .process("Shaders/MetalShaders")
      ],
    ),

    .target(
      name: "MotionKit",
      dependencies: [
        .extDependency(.coreTools),
        .extDependency(.viewTools),
        .module(.viewKitCore),
      ],
    ),

    .testTarget(
      name: "GraphicsKitTests",
      dependencies: ["GraphicsKit"],
    ),

    .testTarget(
      name: "ViewKitCoreTests",
      dependencies: [
        .module(.viewKitCore),
        .extDependency(.coreTools),
      ],
    ),

  ],

)

// MARK: - Helpers
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
  case stringTools
  case colourTools
  case viewTools
  case vectorKit
  case enumMacros
  case casePaths
  case macroToolkit

  var reference: (String, String?) {
    switch self {
      case .coreTools: ("CoreTools", "ToolKit")
      case .stringTools: ("StringTools", "ToolKit")
      case .colourTools: ("ColourTools", "ToolKit")
      case .viewTools: ("ViewTools", "ToolKit")
      case .vectorKit: ("VectorKit", nil)
      case .enumMacros: ("EnumMacros", nil)
      case .casePaths: ("CasePaths", "swift-case-paths")
      case .macroToolkit: ("MacroToolkit", "swift-macro-toolkit")
    }
  }
}

enum InternalModule {
  //  case baseTools
  case baseUI
  case graphicsKit
  case viewKitCore
  //  case layoutKit
  case motionKit
  //  case waveKit

  var name: String {
    switch self {
      //      case .baseTools: "BaseTools"
      case .baseUI: "BaseUI"
      case .graphicsKit: "GraphicsKit"
      case .viewKitCore: "ViewKitCore"
      //      case .layoutKit: "LayoutKit"
      case .motionKit: "MotionKit"
    //      case .waveKit: "WaveKit"
    }
  }
}
