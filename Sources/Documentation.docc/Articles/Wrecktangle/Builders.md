# Wrecktangle Builders

## FrameBuilder

Builder tips

/// `buildArray` receives an array of whatever your builder’s
/// base `buildBlock` returns.
///
/// So if you have:
/// ```
/// buildBlock(_ components: Box.Part...) -> Box.PartMap
/// ```
///
/// then you get:
/// ```
/// buildArray(_ components: [Box.PartMap])
/// ```
///
/// That is — an array of dictionaries, not an array of single Parts.
/// If you ever get an error like:
///
/// > Cannot convert value of type `[Box.PartMap]`
/// > to expected argument type `[Box.Part]`
///
/// …it usually means you’ve changed one of the `build*` return types
/// (say buildBlock returns `[Box.Part]` but buildArray expects `[Box.PartMap]`).
/// They must all line up perfectly — that’s the most common “silent killer” in these setups.

