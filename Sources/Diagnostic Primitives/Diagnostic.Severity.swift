extension Diagnostic {
    /// Semantic severity of a diagnostic.
    ///
    /// Ordered from most to least severe. Presentation (colors, icons)
    /// is the responsibility of rendering packages, not primitives.
    ///
    /// Aligned with established diagnostic models:
    /// - Swift compiler: error, warning, note, remark
    /// - LSP (Language Server Protocol): error, warning, information, hint
    /// - SARIF: error, warning, note, none
    public enum Severity: Int, Sendable, Hashable, Comparable, CaseIterable, Codable {
        case error
        case warning
        case note
        case remark
    }
}

// MARK: - Comparable

extension Diagnostic.Severity {
    /// Orders severities from most to least severe.
    public static func < (lhs: Self, rhs: Self) -> Bool {
        // swift-linter:disable:next raw value access
        // REASON: same-type implementation of `Comparable`'s own `<`
        // requirement — this is the enum's own witness boundary, comparing
        // its `RawValue: Int` backing rather than a consumer bypassing the
        // typed-conversion ladder.
        lhs.rawValue < rhs.rawValue
    }
}
