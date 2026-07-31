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
    /// Namespace for wire-format representations of this severity.
    public struct Wire {
        @usableFromInline
        let severity: Diagnostic.Severity

        @inlinable
        package init(_ severity: Diagnostic.Severity) {
            self.severity = severity
        }
    }

    /// Accessor for wire-format representations of this severity.
    @inlinable
    public var wire: Wire { Wire(self) }
}

extension Diagnostic.Severity.Wire {
    /// The canonical wire-format token for this severity.
    ///
    /// `token` returns the lowercase identifier emitted by reporters
    /// targeting standard diagnostic wire formats (SARIF, SwiftLint
    /// textual, GCC-style `file:line:col: severity:` lines, LSP
    /// DiagnosticSeverity-as-string variants).
    ///
    /// | Severity | token |
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
    /// above; this maps to `.note` in `token` (lossy compression).
    /// Consumers needing strict SARIF semantics should map
    /// `.remark → "note"` separately at their boundary; the canonical
    /// `token` here uses `"remark"` for `.remark` to preserve the
    /// distinction at the swift-diagnostic-primitives layer.
    @inlinable
    public var token: Swift.String {
        switch severity {
        case .error: "error"
        case .warning: "warning"
        case .note: "note"
        case .remark: "remark"
        }
    }
}
