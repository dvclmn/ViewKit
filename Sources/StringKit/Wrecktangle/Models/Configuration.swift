//
//  Configuration.swift
//  BoxCore
//
//  Created by Dave Coleman on 23/8/2024.
//

extension Box {

  /// Defines the appearance and behavior of a `Box`.
  ///
  /// Use `Config` to customize various aspects of a `Box`,
  /// such as its theme, width, and content limitations.
  public struct Config: Sendable {

    /// The visual theme of the box.
    public var theme: Theme

    /// The width of the box in `Character`s.
    ///
    /// This value determines the overall width of the box, including its borders.
    /// The content will be wrapped to fit within this width.
    public var width: Int

    /// The maximum number of lines for the header.
    ///
    /// If set, the header will be truncated if it exceeds this number of lines.
    /// Set to `nil` for no limit.
    public var headerLineLimit: Int

    /// The maximum number of lines for the main content.
    ///
    /// If set, the content will be truncated if it exceeds this number of lines.
    /// Set to `nil` for no limit.
    public var contentLineLimit: Int

    public let shouldHyphenate: Bool

    /// Display metadata about the box itself
    public var metrics: Metrics
    public let counterStyle: TextCore.WidthCounterStyle

    public init(
      theme: Theme = Theme(),
      width: Int = 60,
      headerLineLimit: Int = 0,
      contentLineLimit: Int = 0,
      shouldHyphenate: Bool = true,
      metrics: Metrics = [],
      counterStyle: TextCore.WidthCounterStyle = .ruler
    ) {
      self.theme = theme
      self.width = width
      self.headerLineLimit = headerLineLimit
      self.contentLineLimit = contentLineLimit
      self.shouldHyphenate = shouldHyphenate
      self.metrics = metrics
      self.counterStyle = counterStyle
    }

    /// The default configuration for a `Box`.
    public static let `default` = Config()
  }

}
