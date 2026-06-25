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

extension Diagnostic {
    /// A single diagnostic record — one finding emitted by a diagnostic-emitting tool such as a linter, audit pass, or build-graph checker.
    ///
    /// A record composes typed primitives from the ecosystem:
    ///
    /// - `location` — a `Source.Location` carrying file identity and a
    ///   line:column position; never a raw `Int`.
    /// - `severity` — a `Diagnostic.Severity` (error / warning / note / remark).
    /// - `identifier` — the stable rule or diagnostic identifier, e.g.
    ///   `unchecked_call_site`.
    /// - `message` — the human-readable explanation.
    ///
    /// Records are value types conforming to `Equatable` and `Hashable` for
    /// deduplication, `Codable` for serialization, and `Comparable` for stable
    /// reporter ordering.
    public struct Record: Sendable, Equatable, Hashable, Codable {
        /// The source location where the diagnostic was emitted.
        public let location: Source.Location

        /// The semantic severity.
        public let severity: Severity

        /// Stable identifier of the rule / check / pass that emitted this
        /// diagnostic.
        ///
        /// Convention: `lower_snake_case`.
        public let identifier: Swift.String

        /// Human-readable explanation.
        public let message: Swift.String

        /// Creates a diagnostic record from a source location, severity, identifier, and message.
        @inlinable
        public init(
            location: Source.Location,
            severity: Severity,
            identifier: Swift.String,
            message: Swift.String
        ) {
            self.location = location
            self.severity = severity
            self.identifier = identifier
            self.message = message
        }
    }
}

// MARK: - Comparable

extension Diagnostic.Record: Comparable {
    /// Orders records lexicographically by location, then severity, then identifier, then message.
    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        if lhs.location != rhs.location { return lhs.location < rhs.location }
        if lhs.severity != rhs.severity { return lhs.severity < rhs.severity }
        if lhs.identifier != rhs.identifier { return lhs.identifier < rhs.identifier }
        return lhs.message < rhs.message
    }
}

// MARK: - CustomStringConvertible

extension Diagnostic.Record: CustomStringConvertible {
    /// A colon-separated rendering of the form `location: severity: identifier: message`.
    @inlinable
    public var description: Swift.String {
        "\(location): \(severity): \(identifier): \(message)"
    }
}
