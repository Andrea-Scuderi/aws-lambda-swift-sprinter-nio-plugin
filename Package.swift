// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LambdaSwiftSprinterNioPlugin",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "LambdaSwiftSprinterNioPlugin",
            targets: ["LambdaSwiftSprinterNioPlugin"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        //.package(path: "../aws-lambda-swift-sprinter-core/"),
        .package(url: "https://github.com/swift-sprinter/aws-lambda-swift-sprinter-core", from: "1.0.0-alpha.2"),
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.0.0-alpha.4"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "LambdaSwiftSprinterNioPlugin",
            dependencies: ["LambdaSwiftSprinter", "AsyncHTTPClient"]
        ),
        .testTarget(
            name: "LambdaSwiftSprinterNioPluginTests",
            dependencies: ["LambdaSwiftSprinterNioPlugin"]
        ),
    ]
)
