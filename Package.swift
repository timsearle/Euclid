// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Euclid",
    platforms: [.macOS(.v10_11),
    .iOS(.v9),
    .tvOS(.v10),
    .watchOS(.v3)],
    products: [
        .library(name: "Euclid", targets: ["Euclid"])
    ],
    targets: [
        .target(
            name: "Euclid",
            path: "Sources"
        ),
        .testTarget(
            name: "EuclidTests",
            dependencies: ["Euclid"],
            path: "Euclid Tests"
        )
    ],
    swiftLanguageVersions: [.v5]
)
