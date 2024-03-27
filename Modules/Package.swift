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
        .library(
            name: "Weather",
            targets: ["Weather"]),
        .library(
            name: "FavoriteNews",
            targets: ["FavoriteNews"]),
        .library(
            name: "DetailsNews",
            targets: ["DetailsNews"]),
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
            name: "DetailsNews",
            dependencies: ["INewsNowCore"]),
        .testTarget(
            name: "DetailsNewsTests",
            dependencies: ["DetailsNews"]),
        .target(
            name: "FavoriteNews",
            dependencies: ["INewsNowCore"]),
        .testTarget(
            name: "FavoriteNewsTests",
            dependencies: ["FavoriteNews"]),
        .target(
            name: "Weather",
            dependencies: ["Service", "INewsNowCore"]),
        .testTarget(
            name: "WeatherTests",
            dependencies: ["Weather"]),
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
