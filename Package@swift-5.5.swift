// swift-tools-version:5.5
/*
 * Copyright 2023, MobileCoin Authors All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import PackageDescription
// swiftformat puts the next import before the tools version.
// swiftformat:disable:next sortedImports
import class Foundation.ProcessInfo

let packageName = "protoc-gen-http-swift"

// MARK: - Package Dependencies

let packageDependencies: [Package.Dependency] = [
  .package(
    name: "SwiftProtobuf",
    url: "https://github.com/apple/swift-protobuf.git",
    from: "1.20.2"
  ),
  .package(
    url: "https://github.com/apple/swift-argument-parser.git",
    from: "1.0.0"
  ),
]
// MARK: - Target Dependencies

extension Target.Dependency {
  // Target dependencies; external
  static let protocGenHTTPSwift: Self = .target(name: "protoc-gen-http-swift")

  // Product dependencies
  static let argumentParser: Self = .product(
    name: "ArgumentParser",
    package: "swift-argument-parser"
  )
  static let protobuf: Self = .product(name: "SwiftProtobuf", package: "SwiftProtobuf")
  static let protobufPluginLibrary: Self = .product(
    name: "SwiftProtobufPluginLibrary",
    package: "SwiftProtobuf"
  )
}

// MARK: - Targets

extension Target {
  static let protocGenHTTPSwift: Target = .executableTarget(
    name: "protoc-gen-http-swift",
    dependencies: [
      .protobuf,
      .protobufPluginLibrary,
    ],
    exclude: [
      "README.md",
    ]
  )
}

// MARK: - Products

extension Product {
  static let protocGenHTTPSwift: Product = .executable(
    name: "protoc-gen-http-swift",
    targets: ["protoc-gen-http-swift"]
  )
}

// MARK: - Package

let package = Package(
  name: packageName,
  products: [
    .protocGenHTTPSwift,
  ],
  dependencies: packageDependencies,
  targets: [
    .protocGenHTTPSwift,
  ]
)
