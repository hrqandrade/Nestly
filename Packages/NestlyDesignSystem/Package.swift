// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "NestlyDesignSystem",
    platforms: [.iOS(.v18)],
    products: [.library(name: "NestlyDesignSystem", targets: ["NestlyDesignSystem"])],
    targets: [.target(name: "NestlyDesignSystem")]
)

