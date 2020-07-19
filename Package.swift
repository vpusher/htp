// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Htp",
    products: [
        .library(
            name: "Htp",
            targets: ["Htp"]),
    ],
    dependencies: [
        .package(url: "https://github.com/httpswift/swifter.git", .upToNextMajor(from: "1.4.7"))
    ],
    targets: [
        .target(
            name: "Htp",
            dependencies: []),
        .testTarget(
            name: "HtpTests",
            dependencies: ["Htp", "Swifter"]),
    ]
)
