// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "Astrarium",
    platforms: [
      .iOS(.v15)
    ],
    products: [
      .library(name: "Astrarium", targets: ["Astrarium"])
    ],
    targets: [
      .target(
        name: "Astrarium",
        path: "./Sources/Core",
        linkerSettings: [
          .linkedFramework("UIKit", .when(platforms: [.iOS])),
        ]
      )
    ],
    swiftLanguageVersions: [.v5]
)
