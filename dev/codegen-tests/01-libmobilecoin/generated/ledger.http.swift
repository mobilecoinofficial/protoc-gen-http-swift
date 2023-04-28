//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: ledger.proto
//

//
// Copyright 2023, MobileCoin Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
#if canImport(LibMobileCoinCommon)
import LibMobileCoinCommon
#endif
#if canImport(SwiftProtobuf)
import SwiftProtobuf
#endif


/// Usage: instantiate `FogLedger_FogMerkleProofAPIRestClient`, then call methods of this protocol to make API calls.
public protocol FogLedger_FogMerkleProofAPIRestClientProtocol: HTTPClient {
  var serviceName: String { get }

  func auth(
    _ request: Attest_AuthMessage,
    callOptions: HTTPCallOptions?
  ) -> HTTPUnaryCall<Attest_AuthMessage, Attest_AuthMessage>

  func getOutputs(
    _ request: Attest_Message,
    callOptions: HTTPCallOptions?
  ) -> HTTPUnaryCall<Attest_Message, Attest_Message>
}

extension FogLedger_FogMerkleProofAPIRestClientProtocol {
  public var serviceName: String {
    return "fog_ledger.FogMerkleProofAPI"
  }

  //// This is called to perform mc-noise IX key exchange with the enclave,
  //// before calling GetOutputs.
  ///
  /// - Parameters:
  ///   - request: Request to send to Auth.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func auth(
    _ request: Attest_AuthMessage,
    callOptions: HTTPCallOptions? = nil
  ) -> HTTPUnaryCall<Attest_AuthMessage, Attest_AuthMessage> {
    return self.makeUnaryCall(
      path: FogLedger_FogMerkleProofAPIClientMetadata.Methods.auth.path,
      request: request,
      callOptions: callOptions ?? self.defaultHTTPCallOptions
    )
  }

  //// Get TxOut's and merkle proofs of membership for these outputs
  //// These requests can be the user's "real" outputs from fog view, in order
  //// to get the needed merkle proof, or their mixins for RingCT.
  ///
  /// - Parameters:
  ///   - request: Request to send to GetOutputs.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func getOutputs(
    _ request: Attest_Message,
    callOptions: HTTPCallOptions? = nil
  ) -> HTTPUnaryCall<Attest_Message, Attest_Message> {
    return self.makeUnaryCall(
      path: FogLedger_FogMerkleProofAPIClientMetadata.Methods.getOutputs.path,
      request: request,
      callOptions: callOptions ?? self.defaultHTTPCallOptions
    )
  }
}

public final class FogLedger_FogMerkleProofAPIRestClient: FogLedger_FogMerkleProofAPIRestClientProtocol {
  public var defaultHTTPCallOptions: HTTPCallOptions

  /// Creates a client for the fog_ledger.FogMerkleProofAPI service.
  ///
  /// - Parameters:
  ///   - defaultHTTPCallOptions: Options to use for each service call if the user doesn't provide them.
  public init(
    defaultHTTPCallOptions: HTTPCallOptions = HTTPCallOptions()
  ) {
    self.defaultHTTPCallOptions = defaultHTTPCallOptions
  }
}

public enum FogLedger_FogMerkleProofAPIClientMetadata {
  public static let serviceDescriptor = HTTPServiceDescriptor(
    name: "FogMerkleProofAPI",
    fullName: "fog_ledger.FogMerkleProofAPI",
    methods: [
      FogLedger_FogMerkleProofAPIClientMetadata.Methods.auth,
      FogLedger_FogMerkleProofAPIClientMetadata.Methods.getOutputs,
    ]
  )

  public enum Methods {
    public static let auth = HTTPMethodDescriptor(
      name: "Auth",
      path: "/fog_ledger.FogMerkleProofAPI/Auth",
      type: HTTPCallType.unary
    )

    public static let getOutputs = HTTPMethodDescriptor(
      name: "GetOutputs",
      path: "/fog_ledger.FogMerkleProofAPI/GetOutputs",
      type: HTTPCallType.unary
    )
  }
}

/// Usage: instantiate `FogLedger_FogKeyImageAPIRestClient`, then call methods of this protocol to make API calls.
public protocol FogLedger_FogKeyImageAPIRestClientProtocol: HTTPClient {
  var serviceName: String { get }

  func auth(
    _ request: Attest_AuthMessage,
    callOptions: HTTPCallOptions?
  ) -> HTTPUnaryCall<Attest_AuthMessage, Attest_AuthMessage>

  func checkKeyImages(
    _ request: Attest_Message,
    callOptions: HTTPCallOptions?
  ) -> HTTPUnaryCall<Attest_Message, Attest_Message>
}

extension FogLedger_FogKeyImageAPIRestClientProtocol {
  public var serviceName: String {
    return "fog_ledger.FogKeyImageAPI"
  }

  //// This is called to perform IX key exchange with the enclave before calling GetOutputs.
  ///
  /// - Parameters:
  ///   - request: Request to send to Auth.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func auth(
    _ request: Attest_AuthMessage,
    callOptions: HTTPCallOptions? = nil
  ) -> HTTPUnaryCall<Attest_AuthMessage, Attest_AuthMessage> {
    return self.makeUnaryCall(
      path: FogLedger_FogKeyImageAPIClientMetadata.Methods.auth.path,
      request: request,
      callOptions: callOptions ?? self.defaultHTTPCallOptions
    )
  }

  //// Check if key images have appeared in the ledger, and if so, when
  ///
  /// - Parameters:
  ///   - request: Request to send to CheckKeyImages.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func checkKeyImages(
    _ request: Attest_Message,
    callOptions: HTTPCallOptions? = nil
  ) -> HTTPUnaryCall<Attest_Message, Attest_Message> {
    return self.makeUnaryCall(
      path: FogLedger_FogKeyImageAPIClientMetadata.Methods.checkKeyImages.path,
      request: request,
      callOptions: callOptions ?? self.defaultHTTPCallOptions
    )
  }
}

public final class FogLedger_FogKeyImageAPIRestClient: FogLedger_FogKeyImageAPIRestClientProtocol {
  public var defaultHTTPCallOptions: HTTPCallOptions

  /// Creates a client for the fog_ledger.FogKeyImageAPI service.
  ///
  /// - Parameters:
  ///   - defaultHTTPCallOptions: Options to use for each service call if the user doesn't provide them.
  public init(
    defaultHTTPCallOptions: HTTPCallOptions = HTTPCallOptions()
  ) {
    self.defaultHTTPCallOptions = defaultHTTPCallOptions
  }
}

public enum FogLedger_FogKeyImageAPIClientMetadata {
  public static let serviceDescriptor = HTTPServiceDescriptor(
    name: "FogKeyImageAPI",
    fullName: "fog_ledger.FogKeyImageAPI",
    methods: [
      FogLedger_FogKeyImageAPIClientMetadata.Methods.auth,
      FogLedger_FogKeyImageAPIClientMetadata.Methods.checkKeyImages,
    ]
  )

  public enum Methods {
    public static let auth = HTTPMethodDescriptor(
      name: "Auth",
      path: "/fog_ledger.FogKeyImageAPI/Auth",
      type: HTTPCallType.unary
    )

    public static let checkKeyImages = HTTPMethodDescriptor(
      name: "CheckKeyImages",
      path: "/fog_ledger.FogKeyImageAPI/CheckKeyImages",
      type: HTTPCallType.unary
    )
  }
}

/// Usage: instantiate `FogLedger_FogBlockAPIRestClient`, then call methods of this protocol to make API calls.
public protocol FogLedger_FogBlockAPIRestClientProtocol: HTTPClient {
  var serviceName: String { get }

  func getBlocks(
    _ request: FogLedger_BlockRequest,
    callOptions: HTTPCallOptions?
  ) -> HTTPUnaryCall<FogLedger_BlockRequest, FogLedger_BlockResponse>
}

extension FogLedger_FogBlockAPIRestClientProtocol {
  public var serviceName: String {
    return "fog_ledger.FogBlockAPI"
  }

  //// Request for all of the TxOuts for a particular range of blocks.
  //// This is meant to help the users recover from "missed blocks" i.e.
  //// data loss in the fog service.
  ///
  /// - Parameters:
  ///   - request: Request to send to GetBlocks.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func getBlocks(
    _ request: FogLedger_BlockRequest,
    callOptions: HTTPCallOptions? = nil
  ) -> HTTPUnaryCall<FogLedger_BlockRequest, FogLedger_BlockResponse> {
    return self.makeUnaryCall(
      path: FogLedger_FogBlockAPIClientMetadata.Methods.getBlocks.path,
      request: request,
      callOptions: callOptions ?? self.defaultHTTPCallOptions
    )
  }
}

public final class FogLedger_FogBlockAPIRestClient: FogLedger_FogBlockAPIRestClientProtocol {
  public var defaultHTTPCallOptions: HTTPCallOptions

  /// Creates a client for the fog_ledger.FogBlockAPI service.
  ///
  /// - Parameters:
  ///   - defaultHTTPCallOptions: Options to use for each service call if the user doesn't provide them.
  public init(
    defaultHTTPCallOptions: HTTPCallOptions = HTTPCallOptions()
  ) {
    self.defaultHTTPCallOptions = defaultHTTPCallOptions
  }
}

public enum FogLedger_FogBlockAPIClientMetadata {
  public static let serviceDescriptor = HTTPServiceDescriptor(
    name: "FogBlockAPI",
    fullName: "fog_ledger.FogBlockAPI",
    methods: [
      FogLedger_FogBlockAPIClientMetadata.Methods.getBlocks,
    ]
  )

  public enum Methods {
    public static let getBlocks = HTTPMethodDescriptor(
      name: "GetBlocks",
      path: "/fog_ledger.FogBlockAPI/GetBlocks",
      type: HTTPCallType.unary
    )
  }
}

/// Usage: instantiate `FogLedger_FogUntrustedTxOutApiRestClient`, then call methods of this protocol to make API calls.
public protocol FogLedger_FogUntrustedTxOutApiRestClientProtocol: HTTPClient {
  var serviceName: String { get }

  func getTxOuts(
    _ request: FogLedger_TxOutRequest,
    callOptions: HTTPCallOptions?
  ) -> HTTPUnaryCall<FogLedger_TxOutRequest, FogLedger_TxOutResponse>
}

extension FogLedger_FogUntrustedTxOutApiRestClientProtocol {
  public var serviceName: String {
    return "fog_ledger.FogUntrustedTxOutApi"
  }

  //// This can be used by a sender who may be sharing their private keys across
  //// multiple parties / devices, to confirm that a transaction that they sent
  //// landed in the blockchain, by confirming that one of the random keys from
  //// a TxOut that they produced appears in the ledger.
  ////
  //// Given the TxOut.pubkey value, we return if it is found, and the num_blocks
  //// value, allowing Alice to determine that her transactions succeeded, or if
  //// num_blocks exceeded her tombstone value, conclude that it failed somehow.
  //// We also return the global tx out index. We don't currently return the block
  //// index or time stamp in which the TxOut appeared.
  ////
  //// This API is NOT attested and Bob, the recipient, SHOULD NOT use it in connection
  //// to the same TxOut, as that will leak the transaction graph to fog operator,
  //// which breaks the privacy statement for fog as a whole.
  ///
  /// - Parameters:
  ///   - request: Request to send to GetTxOuts.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func getTxOuts(
    _ request: FogLedger_TxOutRequest,
    callOptions: HTTPCallOptions? = nil
  ) -> HTTPUnaryCall<FogLedger_TxOutRequest, FogLedger_TxOutResponse> {
    return self.makeUnaryCall(
      path: FogLedger_FogUntrustedTxOutApiClientMetadata.Methods.getTxOuts.path,
      request: request,
      callOptions: callOptions ?? self.defaultHTTPCallOptions
    )
  }
}

public final class FogLedger_FogUntrustedTxOutApiRestClient: FogLedger_FogUntrustedTxOutApiRestClientProtocol {
  public var defaultHTTPCallOptions: HTTPCallOptions

  /// Creates a client for the fog_ledger.FogUntrustedTxOutApi service.
  ///
  /// - Parameters:
  ///   - defaultHTTPCallOptions: Options to use for each service call if the user doesn't provide them.
  public init(
    defaultHTTPCallOptions: HTTPCallOptions = HTTPCallOptions()
  ) {
    self.defaultHTTPCallOptions = defaultHTTPCallOptions
  }
}

public enum FogLedger_FogUntrustedTxOutApiClientMetadata {
  public static let serviceDescriptor = HTTPServiceDescriptor(
    name: "FogUntrustedTxOutApi",
    fullName: "fog_ledger.FogUntrustedTxOutApi",
    methods: [
      FogLedger_FogUntrustedTxOutApiClientMetadata.Methods.getTxOuts,
    ]
  )

  public enum Methods {
    public static let getTxOuts = HTTPMethodDescriptor(
      name: "GetTxOuts",
      path: "/fog_ledger.FogUntrustedTxOutApi/GetTxOuts",
      type: HTTPCallType.unary
    )
  }
}

