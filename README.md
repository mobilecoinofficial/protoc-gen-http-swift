# HTTP Swift Codegen for MobileCoin-Swift

This repository contains a HTTP Swift code generator, that closely models the 
gRPC clients generated by the `grpc-swift` codegenerator:

[gRPC-Swift](https://github.com/grpc/grpc-swift)

We use this in the [MobileCoin Swift](https://github.com/mobilecoinofficial/MobileCoin-Swift)
repo so we can share network wrapping code between HTTP and gRPC.

# `protoc-gen-http-swift`

It is intended for use with Apple's [SwiftProtobuf][swift-protobuf] support for
Protocol Buffers. Both projects contain code generation plugins for `protoc`,
Google's Protocol Buffer compiler, and both contain libraries of supporting code
that is needed to build and run the generated code.

##### Xcode

From Xcode 11 it is possible to [add Swift Package dependencies to Xcode
projects][xcode-spm] and link targets to products of those packages; this is the
easiest way to integrate gRPC Swift with an existing `xcodeproj`.

### Getting the `protoc` Plugins

Binary releases of `protoc`, the Protocol Buffer Compiler, are available on
[GitHub][protobuf-releases].

To build the plugins, run `make plugins` in the main directory. This uses the
Swift Package Manager to build both of the necessary plugins:
`protoc-gen-swift`, which generates Protocol Buffer support code and
`protoc-gen-http-swift`, which generates HTTP interface code.

To install these plugins, just copy the two executables (`protoc-gen-swift` and
`protoc-gen-http-swift`) that show up in the main directory into a directory
that is part of your `PATH` environment variable. Alternatively the full path to
the plugins can be specified when using `protoc`.

## Codegen Examples

See [codegen](dev/codegen)

## Documentation

The `docs` directory contains documentation, including:

- Options for the `protoc` plugin in [`docs/plugin.md`][docs-plugin]

## Security

Please see [SECURITY.md](SECURITY.md).

## License

`protoc-gen-http-swift` Swift is released under the Apache license, repeated in
[LICENSE](LICENSE).

## Contributing

Please get involved! See our [guidelines for contributing](CONTRIBUTING.md).

[docs-apple]: ./docs/apple-platforms.md
[docs-plugin]: ./docs/plugin.md
[docs-quickstart]: ./docs/quick-start.md
[protobuf-releases]: https://github.com/protocolbuffers/protobuf/releases
[swift-protobuf]: https://github.com/apple/swift-protobuf
[xcode-spm]: https://help.apple.com/xcode/mac/current/#/devb83d64851
[branch-new]: https://github.com/mobilecoinofficial/protoc-gen-http-swift/tree/main
