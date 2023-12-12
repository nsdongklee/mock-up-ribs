// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MockupKit",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MockupKit",
            targets: ["MockupKit"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.5.0")),
        .package(url: "https://github.com/uber/RIBs.git", .upToNextMajor(from: "0.9.3")),
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MockupKit",
            dependencies: [
                "RIBs",
                .product(name: "RxCocoa", package: "RxSwift"),
                "Moya",
                .product(name: "RxMoya", package: "Moya"),
                "SnapKit",
            ]),
        .testTarget(
            name: "MockupKitTests",
            dependencies: ["MockupKit"]),
    ]
)
