import Foundation
import CaseDetection
import Persistable
import MetaEnum
import SetOfOptions

// MARK: - Persistable
@Persistable
struct ExampleConfiguration: Sendable {

  @Attribute(originalName: "test") var rounding: Double = 8
  var showCount: Bool = false
}

// MARK: - Case detection
@CaseDetection
enum ExampleEnum {
  case dog
  case cat
  case fish
}

@CaseDetection(includesNames: true)
enum ExampleEnumNames {
  case dog
  case cat
  case fish
  var names: String {
    switch self {
      case .dog: "Dog"
      case .cat: "Dog"
      case .fish: "Dog"
    }
  }
}

// MARK: - MetaEnum

/// Seems to help create a corresponding enum without assoc. values?
@MetaEnum
enum AnotherEnum {
  case bird(Int)
  case whale(String)
  case shark
}

// MARK: - SetOfOptions

/// Synthesises an `OptionSet` to accompany the `enum`
/// Note: The `struct` is a requirement
@SetOfOptions
struct CoolAnimals {
  private enum Options: Int {
    case bat
    case frog
    case ape
  }
}
