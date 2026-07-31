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

import Diagnostic_Primitives_Test_Support
import Testing

extension Diagnostic.Severity {
    @Suite
    struct WireTokenTest {
        @Suite struct Unit {}
    }
}

extension Diagnostic.Severity.WireTokenTest.Unit {
    @Test
    func `error wireToken is "error"`() {
        #expect(Diagnostic.Severity.error.wireToken == "error")
    }

    @Test
    func `warning wireToken is "warning"`() {
        #expect(Diagnostic.Severity.warning.wireToken == "warning")
    }

    @Test
    func `note wireToken is "note"`() {
        #expect(Diagnostic.Severity.note.wireToken == "note")
    }

    @Test
    func `remark wireToken is "remark"`() {
        #expect(Diagnostic.Severity.remark.wireToken == "remark")
    }

    @Test
    func `wireToken is total over allCases`() {
        for severity in Diagnostic.Severity.allCases {
            #expect(!severity.wireToken.isEmpty)
        }
    }
}
