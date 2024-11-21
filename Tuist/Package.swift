// swift-tools-version: 5.9
@preconcurrency import PackageDescription

#if TUIST
@preconcurrency import ProjectDescription

let packageSettings = PackageSettings(
    // Customize the product types for specific package product
    // Default is .staticFramework
    // productTypes: ["Alamofire": .framework,]
    productTypes: ["SwiftSoup": .framework]
)
#endif

let package = Package(
    name: "ClipsterPackage",
    dependencies: [
        // Add your own dependencies here:
        // .package(url: "https://github.com/Alamofire/Alamofire", from: "5.0.0"),
        .package(url: "https://github.com/scinfu/SwiftSoup.git", .upToNextMajor(from: "2.7.5"))
        // You can read more about dependencies here: https://docs.tuist.io/documentation/tuist/dependencies
    ]
)
