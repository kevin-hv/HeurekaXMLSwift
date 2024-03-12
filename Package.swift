// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HeurekaXMLSwift",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .watchOS(.v6),
        .tvOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "HeurekaXMLSwift",
            targets: ["HeurekaXMLSwift"]),
    ],
    dependencies: [
        .package(url: "https://github.com/CoreOffice/XMLCoder.git", from: "0.17.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "HeurekaXMLSwift",
            dependencies: [
                .product(name: "XMLCoder", package: "XMLCoder"),
            ]),
        .testTarget(
            name: "HeurekaXMLSwiftTests",
            dependencies: [
                "HeurekaXMLSwift",
                .product(name: "XMLCoder", package: "XMLCoder"),
                
            ],
            resources: [
                .process("Resources/")
            ]
        ),
        
    ]
)
