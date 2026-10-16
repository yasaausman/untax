// swift-tools-version: 6.2
import PackageDescription

// Dev B: Unfreeze engine + player, atomizer, task path, audio, scoreboard.
let package = Package(
    name: "UntaxKit",
    platforms: [.iOS(.v26)],
    products: [
        .library(name: "UntaxKit", targets: ["UntaxKit"]),
    ],
    dependencies: [
        .package(path: "../SharedKit"),
    ],
    targets: [
        .target(name: "UntaxKit", dependencies: ["SharedKit"]),
        .testTarget(name: "UntaxKitTests", dependencies: ["UntaxKit"]),
    ]
)
