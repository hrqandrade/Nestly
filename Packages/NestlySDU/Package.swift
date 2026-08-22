// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "NestlySDU",
    platforms: [.iOS(.v18)],
    products: [.library(name: "NestlySDU", targets: ["NestlySDU"])],
    targets: [.target(name: "NestlySDU")]
)

