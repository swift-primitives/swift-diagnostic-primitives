// swift-tools-version: 6.3

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
        )
    ],
    dependencies: [
        .package(path: "../swift-source-primitives"),
        // SDG(wraps): diagnostics wrap error concepts for structured reporting
        // .package(path: "../swift-error-primitives"),
    ],
    targets: [
        .target(
            name: "Diagnostic Primitives",
            dependencies: [
                .product(name: "Source Primitives", package: "swift-source-primitives")
            ]
        ),
        .testTarget(
            name: "Diagnostic Primitives Tests",
            dependencies: [
                "Diagnostic Primitives",
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
