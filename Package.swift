// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Astrarium",
    platforms: [
      .iOS(.v9)
    ],
    products: [
      .library(name: "Astrarium", targets: ["Astrarium"])
    ],
    targets: [
      .target(name: "Astrarium", path: "./Sources")
    ],
    swiftLanguageVersions: [.v5]
)
