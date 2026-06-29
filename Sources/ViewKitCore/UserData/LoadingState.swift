//
//  LoadingState.swift
//  ViewKit
//
//  Created by Dave Coleman on 6/2/2026.
//

import EnumMacros
import Foundation

/// The lifecycle and editable in-memory value for a ``UserDataHandler``.
///
/// `UserDataState` is intentionally more than a loading flag. When the state is
/// ``ready(_:)``, its associated value is the current working copy that views
/// read and mutate. The handler's `storage` value is a separate backing value
/// used for hydration and persistence.
@CaseDetection
@AssociatedValues
public enum UserDataState<Value> {
  /// No value has been hydrated into memory yet.
  case idle

  /// A value is currently being loaded or prepared.
  case loading

  /// Loading failed with an error that can be presented by the UI layer.
  case failed(Error)

  /// The handler has an editable in-memory value.
  case ready(Value)
}

/// Compatibility spelling for ``UserDataState``.
///
/// New code should use ``UserDataState`` so the type name communicates that the
/// ready case carries the current user data value.
@available(*, deprecated, renamed: "UserDataState")
public typealias LoadState<Value> = UserDataState<Value>
