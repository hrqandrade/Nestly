// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "NestlyDomain",
    platforms: [.iOS(.v18)],
    products: [.library(name: "NestlyDomain", targets: ["NestlyDomain"])],
    targets: [.target(name: "NestlyDomain")]
)

