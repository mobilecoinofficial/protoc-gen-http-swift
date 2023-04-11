// swift-tools-version:5.6
/*
 * Copyright 2017, gRPC Authors All rights reserved.
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
    url: "https://github.com/apple/swift-protobuf.git",
    from: "1.20.2"
  ),
  .package(
    url: "https://github.com/apple/swift-argument-parser.git",
    // Version is higher than in other Package@swift manifests: 1.1.0 raised the minimum Swift
    // version and indluded async support.
    from: "1.1.1"
  ),
  .package(
    url: "https://github.com/apple/swift-docc-plugin",
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
  static let protobuf: Self = .product(name: "SwiftProtobuf", package: "swift-protobuf")
  static let protobufPluginLibrary: Self = .product(
    name: "SwiftProtobufPluginLibrary",
    package: "swift-protobuf"
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

  static let httpSwiftPlugin: Target = .plugin(
    name: "HTTPSwiftPlugin",
    capability: .buildTool(),
    dependencies: [
      .protocGenHTTPSwift,
    ]
  )
}

// MARK: - Products

extension Product {
  static let protocGenHTTPSwift: Product = .executable(
    name: "protoc-gen-http-swift",
    targets: ["protoc-gen-http-swift"]
  )

  static let httpSwiftPlugin: Product = .plugin(
    name: "HTTPSwiftPlugin",
    targets: ["HTTPSwiftPlugin"]
  )
}

// MARK: - Package

let package = Package(
  name: packageName,
  products: [
    .protocGenHTTPSwift,
    .httpSwiftPlugin,
  ],
  dependencies: packageDependencies,
  targets: [
    // Products
    .protocGenHTTPSwift,
    .httpSwiftPlugin,
  ]
)

extension Array {
  func appending(_ element: Element, if condition: Bool) -> [Element] {
    if condition {
      return self + [element]
    } else {
      return self
    }
  }
}
