let dslOnlyPackage = """
// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "{{packageName}}",
    products: [
        .executable(name: "{{packageName}}", targets: ["{{packageName}}"]),],
    dependencies: [
        .package(url: "https://github.com/bitomule/SwiftyPodsDSL", .branch("master"))
    ],
    targets: [
        .target(
            name: "{{packageName}}",
            dependencies: [
                "SwiftyPodsDSL"
        ])
    ]
)

"""
