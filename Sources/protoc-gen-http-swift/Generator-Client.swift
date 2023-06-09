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
import Foundation
import SwiftProtobuf
import SwiftProtobufPluginLibrary

extension Generator {
  internal func printClient() {
    if self.options.generateClient {
      self.println()
      self.printServiceClientProtocol()
      self.println()
      self.printClientProtocolExtension()
      self.println()
      self.printClassBackedServiceClientImplementation()
      self.println()
      self.printClientMetadata()
    }
  }

  internal func printFunction(
    name: String,
    arguments: [String],
    returnType: String?,
    access: String? = nil,
    sendable: Bool = false,
    async: Bool = false,
    throws: Bool = false,
    genericWhereClause: String? = nil,
    bodyBuilder: (() -> Void)?
  ) {
    // Add a space after access, if it exists.
    let functionHead = (access.map { $0 + " " } ?? "") + (sendable ? "@Sendable " : "")
    let `return` = returnType.map { " -> " + $0 } ?? ""
    let genericWhere = genericWhereClause.map { " " + $0 } ?? ""

    let asyncThrows: String
    switch (async, `throws`) {
    case (true, true):
      asyncThrows = " async throws"
    case (true, false):
      asyncThrows = " async"
    case (false, true):
      asyncThrows = " throws"
    case (false, false):
      asyncThrows = ""
    }

    let hasBody = bodyBuilder != nil

    if arguments.isEmpty {
      // Don't bother splitting across multiple lines if there are no arguments.
      self.println(
        "\(functionHead)func \(name)()\(asyncThrows)\(`return`)\(genericWhere)",
        newline: !hasBody
      )
    } else {
      self.println("\(functionHead)func \(name)(")
      self.withIndentation {
        // Add a comma after each argument except the last.
        arguments.forEach(beforeLast: {
          self.println($0 + ",")
        }, onLast: {
          self.println($0)
        })
      }
      self.println(")\(asyncThrows)\(`return`)\(genericWhere)", newline: !hasBody)
    }

    if let bodyBuilder = bodyBuilder {
      self.println(" {")
      self.withIndentation {
        bodyBuilder()
      }
      self.println("}")
    }
  }

  private func printServiceClientProtocol() {
    let comments = self.service.protoSourceComments()
    if !comments.isEmpty {
      // Source comments already have the leading '///'
      self.println(comments, newline: false)
      self.println("///")
    }
    self.println(
      "/// Usage: instantiate `\(self.clientClassName)`, then call methods of this protocol to make API calls."
    )
    self.println("\(self.access) protocol \(self.clientProtocolName): HTTPClient {")
    self.withIndentation {
      self.println("var serviceName: String { get }")

      for method in service.methods {
        self.println()
        self.method = method

        self.printFunction(
          name: self.methodFunctionName,
          arguments: self.methodArgumentsWithoutDefaults,
          returnType: self.methodReturnType,
          bodyBuilder: nil
        )
      }
    }
    println("}")
  }

  private func printClientProtocolExtension() {
    self.println("extension \(self.clientProtocolName) {")

    self.withIndentation {
      // Service name.
      self.println("\(self.access) var serviceName: String {")
      self.withIndentation {
        self.println("return \"\(self.servicePath)\"")
      }
      self.println("}")

      // Default method implementations.
      self.printMethods()
    }

    self.println("}")
  }

  private func printClassBackedServiceClientImplementation() {
    println("\(access) final class \(clientClassName): \(clientProtocolName) {")
    self.withIndentation {
      println("\(access) var defaultHTTPCallOptions: HTTPCallOptions")
      println()
      println("/// Creates a client for the \(servicePath) service.")
      println("///")
      self.printParameters()
      println(
        "///   - defaultHTTPCallOptions: Options to use for each service call if the user doesn't provide them."
      )
      println("\(access) init(")
      self.withIndentation {
        println("defaultHTTPCallOptions: HTTPCallOptions = HTTPCallOptions()")
      }
      self.println(") {")
      self.withIndentation {
        println("self.defaultHTTPCallOptions = defaultHTTPCallOptions")
      }
      self.println("}")
    }
    println("}")
  }

  private func printMethods() {
    for method in self.service.methods {
      self.println()

      self.method = method
      switch self.streamType {
      case .unary:
        self.printUnaryCall()
      }
    }
  }

  private func printUnaryCall() {
    self.println(self.method.documentation(streamingType: self.streamType), newline: false)
    self.println("///")
    self.printParameters()
    self.printRequestParameter()
    self.printCallOptionsParameter()
    self.println("/// - Returns: A `UnaryCall` with futures for the metadata, status and response.")
    self.printFunction(
      name: self.methodFunctionName,
      arguments: self.methodArguments,
      returnType: self.methodReturnType,
      access: self.access
    ) {
      self.println("return self.makeUnaryCall(")
      self.withIndentation {
        self.println("path: \(self.methodPathUsingClientMetadata),")
        self.println("request: request,")
        self.println("callOptions: callOptions ?? self.defaultHTTPCallOptions")
      }
      self.println(")")
    }
  }

  private func printParameters() {
    println("/// - Parameters:")
  }

  private func printRequestParameter() {
    println("///   - request: Request to send to \(method.name).")
  }

  private func printCallOptionsParameter() {
    println("///   - callOptions: Call options.")
  }

  private func printHandlerParameter() {
    println("///   - handler: A closure called when each response is received from the server.")
  }
}

extension Generator {
  private func printFakeResponseStreams() {
    for method in self.service.methods {
      self.println()

      self.method = method
      switch self.streamType {
      case .unary:
          self.printUnaryResponse()
      }
    }
  }

  private func printUnaryResponse() {
    self.printResponseStream(isUnary: true)
    self.println()
    self.printEnqueueUnaryResponse(isUnary: true)
    self.println()
    self.printHasResponseStreamEnqueued()
  }

  private func printEnqueueUnaryResponse(isUnary: Bool) {
    let name: String
    let responseArg: String
    let responseArgAndType: String
    if isUnary {
      name = "enqueue\(self.method.name)Response"
      responseArg = "response"
      responseArgAndType = "_ \(responseArg): \(self.methodOutputName)"
    } else {
      name = "enqueue\(self.method.name)Responses"
      responseArg = "responses"
      responseArgAndType = "_ \(responseArg): [\(self.methodOutputName)]"
    }

    self.printFunction(
      name: name,
      arguments: [
        responseArgAndType,
        "_ requestHandler: @escaping (FakeRequestPart<\(self.methodInputName)>) -> () = { _ in }",
      ],
      returnType: nil,
      access: self.access
    ) {
      self.println("let stream = self.make\(self.method.name)ResponseStream(requestHandler)")
      if isUnary {
        self.println("// This is the only operation on the stream; try! is fine.")
        self.println("try! stream.sendMessage(\(responseArg))")
      } else {
        self.println("// These are the only operation on the stream; try! is fine.")
        self.println("\(responseArg).forEach { try! stream.sendMessage($0) }")
        self.println("try! stream.sendEnd()")
      }
    }
  }

  private func printResponseStream(isUnary: Bool) {
    let type = isUnary ? "FakeUnaryResponse" : "FakeStreamingResponse"
    let factory = isUnary ? "makeFakeUnaryResponse" : "makeFakeStreamingResponse"

    self
      .println(
        "/// Make a \(isUnary ? "unary" : "streaming") response for the \(self.method.name) RPC. This must be called"
      )
    self.println("/// before calling '\(self.methodFunctionName)'. See also '\(type)'.")
    self.println("///")
    self.println("/// - Parameter requestHandler: a handler for request parts sent by the RPC.")
    self.printFunction(
      name: "make\(self.method.name)ResponseStream",
      arguments: [
        "_ requestHandler: @escaping (FakeRequestPart<\(self.methodInputName)>) -> () = { _ in }",
      ],
      returnType: "\(type)<\(self.methodInputName), \(self.methodOutputName)>",
      access: self.access
    ) {
      self
        .println(
          "return self.fakeChannel.\(factory)(path: \(self.methodPathUsingClientMetadata), requestHandler: requestHandler)"
        )
    }
  }

  private func printHasResponseStreamEnqueued() {
    self
      .println("/// Returns true if there are response streams enqueued for '\(self.method.name)'")
    self.println("\(self.access) var has\(self.method.name)ResponsesRemaining: Bool {")
    self.withIndentation {
      self.println(
        "return self.fakeChannel.hasFakeResponseEnqueued(forPath: \(self.methodPathUsingClientMetadata))"
      )
    }
    self.println("}")
  }
}

extension Generator {
  private var streamType: StreamingType {
    return streamingType(self.method)
  }
}

extension Generator {
  private var methodArguments: [String] {
    switch self.streamType {
    case .unary:
      return [
        "_ request: \(self.methodInputName)",
        "callOptions: HTTPCallOptions? = nil",
      ]
    }
  }

  private var methodArgumentsWithoutDefaults: [String] {
    return self.methodArguments.map { arg in
      // Remove default arg from call options.
      if arg == "callOptions: HTTPCallOptions? = nil" {
        return "callOptions: HTTPCallOptions?"
      } else {
        return arg
      }
    }
  }

  private var methodArgumentsWithoutCallOptions: [String] {
    return self.methodArguments.filter {
      !$0.hasPrefix("callOptions: ")
    }
  }

  private var methodReturnType: String {
    switch self.streamType {
    case .unary:
      return "HTTPUnaryCall<\(self.methodInputName), \(self.methodOutputName)>"
    }
  }
}

extension StreamingType {
  fileprivate var name: String {
    switch self {
    case .unary:
      return "Unary"
    }
  }
}

extension MethodDescriptor {
  var documentation: String? {
    let comments = self.protoSourceComments(commentPrefix: "")
    return comments.isEmpty ? nil : comments
  }

  fileprivate func documentation(streamingType: StreamingType) -> String {
    let sourceComments = self.protoSourceComments()

    if sourceComments.isEmpty {
      return "/// \(streamingType.name) call to \(self.name)\n" // comments end with "\n" already.
    } else {
      return sourceComments // already prefixed with "///"
    }
  }
}

extension Array {
  /// Like `forEach` except that the `body` closure operates on all elements except for the last,
  /// and the `last` closure only operates on the last element.
  fileprivate func forEach(beforeLast body: (Element) -> Void, onLast last: (Element) -> Void) {
    for element in self.dropLast() {
      body(element)
    }
    if let lastElement = self.last {
      last(lastElement)
    }
  }
}
