// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Autolocalizable",
    platforms: [
        .iOS(.v11),
    ],
    products: [
        .library(name: "Autolocalizable", targets: ["Autolocalizable"])
    ],
    targets: [
        .target(
            name: "Autolocalizable",
            dependencies: [],
            path: "Autolocalizable/Classes"
        )
    ]
)
