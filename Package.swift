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
            name: "Euclid",
            dependencies: []),
        .testTarget(
            name: "EuclidTests",
            dependencies: ["Euclid"]),
    ]
)
