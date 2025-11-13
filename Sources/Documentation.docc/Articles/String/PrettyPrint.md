/// ```
/// struct Person: PrettyPrintable {
///   let name: String
///   let age: Int
///   let address: Address?
///   let hobbies: [String]
///
///   func prettyDescription(config: PrettyPrintConfig, depth: Int) -> String {
///     guard depth < config.maxDepth else { return "Person {...}" }
///
///     let ind = indent(depth, config)
///     let nextInd = indent(depth + 1, config)
///
///     return """
///         \(typeName(self, config))Person {
///         \(nextInd)name: \(name.prettyDescription(config: config, depth: depth + 1))
///         \(nextInd)age: \(age.prettyDescription(config: config, depth: depth + 1))
///         \(nextInd)address: \(address.prettyDescription(config: config, depth: depth + 1))
///         \(nextInd)hobbies: \(hobbies.prettyDescription(config: config, depth: depth + 1))
///         \(ind)}
///         """
///   }
/// }
///
/// struct Address: PrettyPrintable {
///   let street: String
///   let city: String
///   let zip: String
///
///   func prettyDescription(config: PrettyPrintConfig, depth: Int) -> String {
///     guard depth < config.maxDepth else { return "Address {...}" }
///
///     let ind = indent(depth, config)
///     let nextInd = indent(depth + 1, config)
///
///     return """
///         \(typeName(self, config))Address {
///         \(nextInd)street: \(street.prettyDescription(config: config, depth: depth + 1))
///         \(nextInd)city: \(city.prettyDescription(config: config, depth: depth + 1))
///         \(nextInd)zip: \(zip.prettyDescription(config: config, depth: depth + 1))
///         \(ind)}
///         """
///   }
/// }
/// ```
// MARK: - Usage Example

/// ```
/// let person = Person(
///   name: "Alice",
///   age: 30,
///   address: Address(street: "123 Main St", city: "Springfield", zip: "12345"),
///   hobbies: ["reading", "cycling", "photography"]
/// )
///
/// let people = [person, person]
/// let nestedData: [String: Any] = [
///   "count": 2,
///   "users": people
/// ]
///
/// // Print with default config
/// print("=== Default Config ===")
/// person.prettyPrint()
///
/// print("\n=== Compact Config ===")
/// person.prettyPrint(config: .compact)
///
/// print("\n=== Custom Config ===")
/// var customConfig = PrettyPrintConfig()
/// customConfig.showTypeNames = false
/// customConfig.indentSize = 4
/// customConfig.arrayPrefix = "🔵 ["
/// customConfig.arraySuffix = "]"
/// person.prettyPrint(config: customConfig)
///
/// print("\n=== Nested Arrays ===")
/// let matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
/// matrix.prettyPrint()
/// ```
