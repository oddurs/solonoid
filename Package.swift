// swift-tools-version: 5.5
import PackageDescription

let package = Package(
    name: "Solonoid",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "SolonoidCore",
            targets: ["SolonoidCore"]
        )
    ],
    dependencies: [
        // Add dependencies here as needed
        // Example:
        // .package(url: "https://github.com/example/package.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "SolonoidCore",
            dependencies: [],
            path: "solonoid Shared",
            publicHeadersPath: ".",
            swiftSettings: [
                .unsafeFlags(["-suppress-warnings"], .when(configuration: .debug))
            ]
        )
    ]
)
