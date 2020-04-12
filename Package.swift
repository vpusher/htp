// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Htp",
    products: [
        .library(
            name: "Htp",
            targets: ["Htp"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Htp",
            dependencies: []),
        .testTarget(
            name: "HtpTests",
            dependencies: ["Htp"]),
    ]
)
