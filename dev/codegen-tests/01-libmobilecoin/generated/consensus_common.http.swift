//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: consensus_common.proto
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


//// Blockchain API shared between clients and peers.
///
/// Usage: instantiate `ConsensusCommon_BlockchainAPIRestClient`, then call methods of this protocol to make API calls.
public protocol ConsensusCommon_BlockchainAPIRestClientProtocol: HTTPClient {
  var serviceName: String { get }

  func getLastBlockInfo(
    _ request: SwiftProtobuf.Google_Protobuf_Empty,
    callOptions: HTTPCallOptions?
  ) -> HTTPUnaryCall<SwiftProtobuf.Google_Protobuf_Empty, ConsensusCommon_LastBlockInfoResponse>

  func getBlocks(
    _ request: ConsensusCommon_BlocksRequest,
    callOptions: HTTPCallOptions?
  ) -> HTTPUnaryCall<ConsensusCommon_BlocksRequest, ConsensusCommon_BlocksResponse>
}

extension ConsensusCommon_BlockchainAPIRestClientProtocol {
  public var serviceName: String {
    return "consensus_common.BlockchainAPI"
  }

  /// Unary call to GetLastBlockInfo
  ///
  /// - Parameters:
  ///   - request: Request to send to GetLastBlockInfo.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func getLastBlockInfo(
    _ request: SwiftProtobuf.Google_Protobuf_Empty,
    callOptions: HTTPCallOptions? = nil
  ) -> HTTPUnaryCall<SwiftProtobuf.Google_Protobuf_Empty, ConsensusCommon_LastBlockInfoResponse> {
    return self.makeUnaryCall(
      path: ConsensusCommon_BlockchainAPIClientMetadata.Methods.getLastBlockInfo.path,
      request: request,
      callOptions: callOptions ?? self.defaultHTTPCallOptions
    )
  }

  /// Unary call to GetBlocks
  ///
  /// - Parameters:
  ///   - request: Request to send to GetBlocks.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func getBlocks(
    _ request: ConsensusCommon_BlocksRequest,
    callOptions: HTTPCallOptions? = nil
  ) -> HTTPUnaryCall<ConsensusCommon_BlocksRequest, ConsensusCommon_BlocksResponse> {
    return self.makeUnaryCall(
      path: ConsensusCommon_BlockchainAPIClientMetadata.Methods.getBlocks.path,
      request: request,
      callOptions: callOptions ?? self.defaultHTTPCallOptions
    )
  }
}

public final class ConsensusCommon_BlockchainAPIRestClient: ConsensusCommon_BlockchainAPIRestClientProtocol {
  public var defaultHTTPCallOptions: HTTPCallOptions

  /// Creates a client for the consensus_common.BlockchainAPI service.
  ///
  /// - Parameters:
  ///   - defaultHTTPCallOptions: Options to use for each service call if the user doesn't provide them.
  public init(
    defaultHTTPCallOptions: HTTPCallOptions = HTTPCallOptions()
  ) {
    self.defaultHTTPCallOptions = defaultHTTPCallOptions
  }
}

public enum ConsensusCommon_BlockchainAPIClientMetadata {
  public static let serviceDescriptor = HTTPServiceDescriptor(
    name: "BlockchainAPI",
    fullName: "consensus_common.BlockchainAPI",
    methods: [
      ConsensusCommon_BlockchainAPIClientMetadata.Methods.getLastBlockInfo,
      ConsensusCommon_BlockchainAPIClientMetadata.Methods.getBlocks,
    ]
  )

  public enum Methods {
    public static let getLastBlockInfo = HTTPMethodDescriptor(
      name: "GetLastBlockInfo",
      path: "/consensus_common.BlockchainAPI/GetLastBlockInfo",
      type: HTTPCallType.unary
    )

    public static let getBlocks = HTTPMethodDescriptor(
      name: "GetBlocks",
      path: "/consensus_common.BlockchainAPI/GetBlocks",
      type: HTTPCallType.unary
    )
  }
}

