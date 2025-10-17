import Foundation
import EnumMacros
import Persistable

// MARK: - Persistable
@Persistable
struct ExampleConfiguration: Sendable {

  var rounding: Double = 8
//  @Attribute(originalName: "test") var rounding: Double = 8
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
@SetOfOptions<Int>
struct CoolAnimals {
  enum Options: Int {
    case bat
    case frog
    case ape
  }
}

// MARK: - SampleData

//@SampleBuilder(numberOfItems: 10, dataGeneratorType: .default)
//struct Example {
//  let item1: UUID
//  let item2: Int
//}
//
//for element in Example.sample {
//  print(element.item1, element.item2)
//}
//
//@SampleBuilder(numberOfItems: 3, dataGeneratorType: .random)
//struct Review {
//  let rating: Int
//  let time: Date
//  let product: Product
//}
//
//@SampleBuilder(numberOfItems: 3, dataGeneratorType: .random)
//struct Product {
//  var price: Int
//  var description: String
//}
//
//@SampleBuilder(numberOfItems: 3, dataGeneratorType: .random)
//struct Profile {
//  @SampleBuilderItem(category: .firstName)
//  let firstName: String
//
//  @SampleBuilderItem(category: .lastName)
//  let lastName: String
//
//  @SampleBuilderItem(category: .image(width: 300, height: 300))
//  let profileImage: URL
//}
//
//for profile in Profile.sample {
//  print(profile.firstName, profile.lastName, profile.profileImage)
//}
//
//@SampleBuilder(numberOfItems: 6, dataGeneratorType: .random)
//enum MyEnum {
//  indirect case case1(String, Int, String, [String])
//  case case2
//  case case3(Product)
//  case case4([String: Product])
//}
