// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "CategoryNews",
            targets: ["CategoryNews"]),
        .library(
            name: "WorldNews",
            targets: ["WorldNews"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "WorldNews",
            dependencies: ["Service", "INewsNowCore"]),
        .testTarget(
            name: "WorldNewsTests",
            dependencies: ["WorldNews"]),
        .target(
            name: "INewsNowCore",
            dependencies: []),
        .testTarget(
            name: "INewsNowCoreTests",
            dependencies: ["INewsNowCore"]),
        .target(
            name: "Service",
            dependencies: []),
        .testTarget(
            name: "ServiceTests",
            dependencies: ["Service"]),
        .target(
            name: "CategoryNews",
            dependencies: ["INewsNowCore", "Service"]),
        .testTarget(
            name: "CategoryNewsTests",
            dependencies: ["CategoryNews"]),
    ]
)
