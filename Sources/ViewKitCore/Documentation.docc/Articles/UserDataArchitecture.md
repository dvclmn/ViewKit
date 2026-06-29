# User Data Architecture

Understand how `UserDataHandler` separates loaded user data from backing storage.

## Overview

`UserDataHandler` is a small state container for features that edit a single user-owned value. Its important detail is that it keeps two copies of that value for two different jobs.

`dataState` is the working state. When it is `UserDataState.ready`, the associated value is the editable in-memory data that views read, bindings mutate, imports replace, and undo restores.

`storage` is the backing value. It is the value used to hydrate the working state and the value that eventually receives persisted changes. While the handler is ready, it should not be treated as the live editing value.

## Flow

1. A handler starts as `idle` or `loading`.
2. `UserDataView` reads `storage` and calls `setReady(_:)`.
3. Views read and mutate the ready value through `userData()`, `userDataIfPresent`, `setValue`, or `dataBinding(_:)`.
4. `UserDataView` observes ready-value changes and calls `userDataDidChange(updateStorage:)`.
5. The debouncer coalesces rapid changes before the caller writes the new value into `storage` or another persistence layer.

## Why Ready Holds The Value

The ready case carries the value so readiness and the editable snapshot cannot drift apart. A separate `isReady` flag plus a separate optional value would create invalid combinations such as "ready but no value" or "not ready but value present". Keeping the value inside `UserDataState.ready` makes the valid states explicit.

This does mean the enum is not merely a loading indicator. `UserDataState` is the canonical name because it describes both the lifecycle and the value.

## Storage Is Not The Source Of Truth While Editing

`storage` is still necessary because many clients use a persistence wrapper, shared value, or disk-backed field as the long-lived value. The handler copies that value into `dataState` so UI editing can use one consistent pipeline for mutation, undo, import/export, and debounced persistence.

During editing, the source of truth is the ready associated value. `storage` catches up when `userDataDidChange(updateStorage:)` runs.

## API Notes

Use `UserDataState` in new code. `LoadState` remains as a compatibility typealias for older clients, but it hides the important fact that the ready case owns the editable value.

Use `UserDataView(store:persistUserData:content:)` when connecting a handler to SwiftUI. The older `DataStoreView` spelling remains as a compatibility alias.

Use `setValue` or `dataBinding(_:)` for user edits rather than assigning to `dataState` directly. That keeps undo and the persistence trigger on the same path.
