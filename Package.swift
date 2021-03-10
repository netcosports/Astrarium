// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Astrarium",
    platforms: [
      .iOS(.v9)
    ],
    products: [
      .library(name: "AstrariumCore", targets: ["AstrariumCore"])
    ],
    dependencies: [],
    targets: [
      .target(name: "AstrariumCore", dependencies: [], path: "./Sources/Core")
    ],
    swiftLanguageVersions: [.v5]
)
