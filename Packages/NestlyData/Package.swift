// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "NestlyData",
    platforms: [.iOS(.v18)],
    products: [.library(name: "NestlyData", targets: ["NestlyData"])],
    targets: [.target(name: "NestlyData")]
)

