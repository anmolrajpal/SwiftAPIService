// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftAPIService",
    platforms: [
      .iOS(.v15),
      .macOS(.v12),
      .tvOS(.v12),
      .watchOS(.v4)
    ],
    
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftAPIService",
            targets: ["SwiftAPIService"]),
        
         .plugin(
             name: "GenerateHelpers",
             targets: ["GenerateHelpers"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftAPIService"
        ),
        
         .plugin(
            name: "GenerateHelpers",
            capability: .command(
               intent: .custom(verb: "generate-helpers",
                               description: "Generates the default placeholder files for the SwiftAPIService to plug and play network calls"),
               permissions: [
                  .writeToPackageDirectory(reason: "This command writes Endpoint.swift, SwiftAPIConfiguration.swift and SwiftAPIService+View.swift files in  a subdirectory to implement basic requirements for SwiftAPIService module.")
               ]
            )),
        .testTarget(
            name: "SwiftAPIServiceTests",
            dependencies: ["SwiftAPIService"]),
    ]
)
