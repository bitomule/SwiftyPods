let packageTemplate = """
// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "{{packageName}}",
    products: [
        .executable(name: "{{packageName}}", targets: ["{{packageName}}"]),],
    dependencies: [
        .package(url: "git@github.com:bitomule/SwiftyPods", .branch("master")),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1")
    ],
    targets: [
        .target(
            name: "{{packageName}}",
            dependencies: [
                "ArgumentParser",
                "PodsDSL",
                "PodfileBuilder"
        ])
    ]
)

"""
