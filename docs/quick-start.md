# protoc-gen-http-swift Swift Quick Start

## Before you begin

### Prerequisites

#### Swift Version

Tequires Swift 5.0 or higher.

#### Install Protocol Buffers v3

Install the protoc compiler that is used to generate HTTP service code. The
simplest way to do this is to download pre-compiled binaries for your
platform (`protoc-<version>-<platform>.zip`) from here:
[https://github.com/google/protobuf/releases][protobuf-releases].

* Unzip this file.
* Update the environment variable `PATH` to include the path to the `protoc`
  binary file.

### Download the example

You'll need a local copy of the example code to work through this quickstart.
Download the example code from our GitHub repository (the following command
clones the entire repository, but you just need the examples for this quickstart
and other tutorials):

```sh
$ # Clone the repository at the latest release to get the example code:
$ git clone -b 1.13.0 https://github.com/mobilecoinofficial/protoc-gen-http-swift
$ # Navigate to the repository
$ cd protoc-gen-http-swift/
```

### What's next

[protobuf-releases]: https://github.com/google/protobuf/releases
[basic-tutorial]: ./basic-tutorial.md
