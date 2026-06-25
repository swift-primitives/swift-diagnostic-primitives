// swift-tools-version: 6.3.1

import PackageDescription

let package = Package(
    name: "swift-diagnostic-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        .library(
            name: "Diagnostic Primitives",
            targets: ["Diagnostic Primitives"]
        ),
        .library(
            name: "Diagnostic Primitives Test Support",
            targets: ["Diagnostic Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-source-primitives.git", branch: "main"),
        // SDG(wraps): diagnostics wrap error concepts for structured reporting
        // .package(url: "https://github.com/swift-primitives/swift-error-primitives.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Diagnostic Primitives",
            dependencies: [
                .product(name: "Source Primitives", package: "swift-source-primitives")
            ]
        ),
        .target(
            name: "Diagnostic Primitives Test Support",
            dependencies: [
                "Diagnostic Primitives",
                .product(name: "Source Primitives Test Support", package: "swift-source-primitives"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Diagnostic Primitives Tests",
            dependencies: [
                "Diagnostic Primitives",
                "Diagnostic Primitives Test Support",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
