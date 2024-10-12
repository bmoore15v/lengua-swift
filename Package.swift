// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "LenguaSwift",
    products: [
        .library(
            name: "LenguaSwift",
            targets: ["LenguaSwift"]),
    ],
    targets: [
        .target(
            name: "LenguaSwift",
            dependencies: []),
        .testTarget(
            name: "LenguaTests",
            dependencies: ["LenguaSwift"]),
    ]
)