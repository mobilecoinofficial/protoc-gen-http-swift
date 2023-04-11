//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: consensus_client.proto
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
import LibMobileCoin
import SwiftProtobuf


/// Usage: instantiate `ConsensusClient_ConsensusClientAPIRestClient`, then call methods of this protocol to make API calls.
public protocol ConsensusClient_ConsensusClientAPIRestClientProtocol: HTTPClient {
  var serviceName: String { get }

  func clientTxPropose(
    _ request: Attest_Message,
    callOptions: HTTPCallOptions?
  ) -> HTTPUnaryCall<Attest_Message, ConsensusCommon_ProposeTxResponse>

  func proposeMintConfigTx(
    _ request: External_MintConfigTx,
    callOptions: HTTPCallOptions?
  ) -> HTTPUnaryCall<External_MintConfigTx, ConsensusClient_ProposeMintConfigTxResponse>

  func proposeMintTx(
    _ request: External_MintTx,
    callOptions: HTTPCallOptions?
  ) -> HTTPUnaryCall<External_MintTx, ConsensusClient_ProposeMintTxResponse>

  func getNodeConfig(
    _ request: SwiftProtobuf.Google_Protobuf_Empty,
    callOptions: HTTPCallOptions?
  ) -> HTTPUnaryCall<SwiftProtobuf.Google_Protobuf_Empty, ConsensusConfig_ConsensusNodeConfig>
}

extension ConsensusClient_ConsensusClientAPIRestClientProtocol {
  public var serviceName: String {
    return "consensus_client.ConsensusClientAPI"
  }

  //// This API call is made with an encrypted payload for the enclave,
  //// indicating a new value to be acted upon.
  ///
  /// - Parameters:
  ///   - request: Request to send to ClientTxPropose.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func clientTxPropose(
    _ request: Attest_Message,
    callOptions: HTTPCallOptions? = nil
  ) -> HTTPUnaryCall<Attest_Message, ConsensusCommon_ProposeTxResponse> {
    return self.makeUnaryCall(
      path: ConsensusClient_ConsensusClientAPIClientMetadata.Methods.clientTxPropose.path,
      request: request,
      callOptions: callOptions ?? self.defaultHTTPCallOptions
    )
  }

  //// Propose a new MintConfigTx.
  ///
  /// - Parameters:
  ///   - request: Request to send to ProposeMintConfigTx.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func proposeMintConfigTx(
    _ request: External_MintConfigTx,
    callOptions: HTTPCallOptions? = nil
  ) -> HTTPUnaryCall<External_MintConfigTx, ConsensusClient_ProposeMintConfigTxResponse> {
    return self.makeUnaryCall(
      path: ConsensusClient_ConsensusClientAPIClientMetadata.Methods.proposeMintConfigTx.path,
      request: request,
      callOptions: callOptions ?? self.defaultHTTPCallOptions
    )
  }

  //// Propose a new MintTx.
  ///
  /// - Parameters:
  ///   - request: Request to send to ProposeMintTx.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func proposeMintTx(
    _ request: External_MintTx,
    callOptions: HTTPCallOptions? = nil
  ) -> HTTPUnaryCall<External_MintTx, ConsensusClient_ProposeMintTxResponse> {
    return self.makeUnaryCall(
      path: ConsensusClient_ConsensusClientAPIClientMetadata.Methods.proposeMintTx.path,
      request: request,
      callOptions: callOptions ?? self.defaultHTTPCallOptions
    )
  }

  //// Get current node configuration.
  ///
  /// - Parameters:
  ///   - request: Request to send to GetNodeConfig.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func getNodeConfig(
    _ request: SwiftProtobuf.Google_Protobuf_Empty,
    callOptions: HTTPCallOptions? = nil
  ) -> HTTPUnaryCall<SwiftProtobuf.Google_Protobuf_Empty, ConsensusConfig_ConsensusNodeConfig> {
    return self.makeUnaryCall(
      path: ConsensusClient_ConsensusClientAPIClientMetadata.Methods.getNodeConfig.path,
      request: request,
      callOptions: callOptions ?? self.defaultHTTPCallOptions
    )
  }
}

public final class ConsensusClient_ConsensusClientAPIRestClient: ConsensusClient_ConsensusClientAPIRestClientProtocol {
  public var defaultHTTPCallOptions: HTTPCallOptions

  /// Creates a client for the consensus_client.ConsensusClientAPI service.
  ///
  /// - Parameters:
  ///   - defaultHTTPCallOptions: Options to use for each service call if the user doesn't provide them.
  public init(
    defaultHTTPCallOptions: HTTPCallOptions = HTTPCallOptions()
  ) {
    self.defaultHTTPCallOptions = defaultHTTPCallOptions
  }
}

public enum ConsensusClient_ConsensusClientAPIClientMetadata {
  public static let serviceDescriptor = HTTPServiceDescriptor(
    name: "ConsensusClientAPI",
    fullName: "consensus_client.ConsensusClientAPI",
    methods: [
      ConsensusClient_ConsensusClientAPIClientMetadata.Methods.clientTxPropose,
      ConsensusClient_ConsensusClientAPIClientMetadata.Methods.proposeMintConfigTx,
      ConsensusClient_ConsensusClientAPIClientMetadata.Methods.proposeMintTx,
      ConsensusClient_ConsensusClientAPIClientMetadata.Methods.getNodeConfig,
    ]
  )

  public enum Methods {
    public static let clientTxPropose = HTTPMethodDescriptor(
      name: "ClientTxPropose",
      path: "/consensus_client.ConsensusClientAPI/ClientTxPropose",
      type: HTTPCallType.unary
    )

    public static let proposeMintConfigTx = HTTPMethodDescriptor(
      name: "ProposeMintConfigTx",
      path: "/consensus_client.ConsensusClientAPI/ProposeMintConfigTx",
      type: HTTPCallType.unary
    )

    public static let proposeMintTx = HTTPMethodDescriptor(
      name: "ProposeMintTx",
      path: "/consensus_client.ConsensusClientAPI/ProposeMintTx",
      type: HTTPCallType.unary
    )

    public static let getNodeConfig = HTTPMethodDescriptor(
      name: "GetNodeConfig",
      path: "/consensus_client.ConsensusClientAPI/GetNodeConfig",
      type: HTTPCallType.unary
    )
  }
}

