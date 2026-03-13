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
    public enum Severity: Int, Sendable, Hashable, Comparable, CaseIterable {
        case error
        case warning
        case note
        case remark

        public static func < (lhs: Self, rhs: Self) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
    }
}
