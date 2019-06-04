// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Euclid",
    products: [
        .library(
            name: "Euclid",
            targets: ["Euclid"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Euclid iOS",
            dependencies: []),
        .target(
            name: "Euclid macOS",
            dependencies: []),
        .target(
            name: "Euclid tvOS",
            dependencies: []),
        .target(
            name: "Euclid watchOS",
            dependencies: []),
        .testTarget(
            name: "EuclidTests",
            dependencies: ["Euclid"]),
    ]
)
