// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Secrets",
    platforms: [
        .macOS("10.15")
    ],
    products: [
        .executable(name: "secrets", targets: ["Secrets"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1")
    ],
    targets: [
        .target(name: "Secrets", dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")])
    ]
)
