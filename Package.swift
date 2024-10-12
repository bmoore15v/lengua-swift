// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "LenguaCompiler",
    products: [
        // The library that others can import, containing the lexer, token, etc.
        .library(
            name: "LenguaInterpreter",
            targets: ["LenguaInterpreter"]
        ),
        // The executable that contains the REPL logic
        .executable(
            name: "LenguaCompiler",
            targets: ["LenguaCompiler"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat.git", from: "0.35.8"),
    ],
    targets: [
        // The library target for core logic
        .target(
            name: "LenguaInterpreter",
            dependencies: []
        ),
        // The executable target for the REPL
        .executableTarget(
            name: "LenguaCompiler",
            dependencies: ["LenguaInterpreter"]
        ),
        // Test target
        .testTarget(
            name: "LenguaTests",
            dependencies: ["LenguaInterpreter"]
        )
    ]
)