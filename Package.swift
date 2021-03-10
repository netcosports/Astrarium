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
    targets: [
      .target(name: "AstrariumCore", path: "./Sources/Core")
    ],
    swiftLanguageVersions: [.v5]
)
