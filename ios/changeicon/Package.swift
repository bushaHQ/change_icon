// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "changeicon",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "changeicon", targets: ["changeicon"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "changeicon",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ],
            cSettings: [
                .headerSearchPath("include/changeicon")
            ]
        )
    ]
)
