let packageTemplate = """
// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "{{packageName}}",
    products: [
        .executable(name: "{{packageName}}", targets: ["{{packageName}}"]),],
    dependencies: [
        .package(url: "git@github.com:bitomule/SwiftyPods", .branch("master"))
    ],
    targets: [
        .target(
            name: "{{packageName}}",
            dependencies: [
                "PodsDSL"
        ])
    ]
)

"""
