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
         targets: ["SwiftAPIService"]
      ),
      .executable(
         name: "generate-helpers",
         targets: ["GenerateHelpersTool"]
      ),
      .plugin(
         name: "GenerateHelpersPlugin",
         targets: ["GenerateHelpersPlugin"]
      )
   ],
   targets: [
      // Targets are the basic building blocks of a package, defining a module or a test suite.
      // Targets can depend on other targets in this package and products from dependencies.
      .target(
         name: "SwiftAPIService"
      ),
      .executableTarget(
         name: "GenerateHelpersTool"
      ),
      .plugin(
         name: "GenerateHelpersPlugin",
         capability: .command(
            intent: .custom(verb: "generate-helpers", description: "Generate the Endpoint.swift file"),
            permissions: [
               .writeToPackageDirectory(reason: "Generate Endpoint.swift file")
            ]
         ),
         dependencies: [
            .target(name: "GenerateHelpersTool")
         ]
      ),
      .testTarget(
         name: "SwiftAPIServiceTests",
         dependencies: ["SwiftAPIService"]),
   ]
)
