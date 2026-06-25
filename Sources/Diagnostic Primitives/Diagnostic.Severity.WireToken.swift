// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-diagnostic-primitives open source project
//
// Copyright (c) 2026 Coen ten Thije Boonkkamp and the swift-diagnostic-primitives project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

extension Diagnostic.Severity {
    /// The canonical wire-format token for this severity.
    ///
    /// `wireToken` returns the lowercase identifier emitted by reporters
    /// targeting standard diagnostic wire formats (SARIF, SwiftLint
    /// textual, GCC-style `file:line:col: severity:` lines, LSP
    /// DiagnosticSeverity-as-string variants).
    ///
    /// | Severity | wireToken |
    /// |----------|-----------|
    /// | `.error` | `"error"` |
    /// | `.warning` | `"warning"` |
    /// | `.note` | `"note"` |
    /// | `.remark` | `"remark"` |
    ///
    /// Reporters consume this canonical mapping rather than re-deriving the
    /// token in each emitter; SARIF's `level` field, SwiftLint's textual
    /// severity prefix, and other consumers all share the four-token
    /// vocabulary.
    ///
    /// Note: SARIF defines `"none"` as a level alongside the four tokens
    /// above; this maps to `.note` in `wireToken` (lossy compression).
    /// Consumers needing strict SARIF semantics should map
    /// `.remark → "note"` separately at their boundary; the canonical
    /// `wireToken` here uses `"remark"` for `.remark` to preserve the
    /// distinction at the swift-diagnostic-primitives layer.
    @inlinable
    public var wireToken: Swift.String {
        switch self {
        case .error: "error"
        case .warning: "warning"
        case .note: "note"
        case .remark: "remark"
        }
    }
}
