#!/bin/bash

cd ../../../
rm Gen/*
make
cd dev/codegen-tests/06-libmobilecoin/

protoc \
  --plugin=../../../.build/debug/protoc-gen-grpc-swift \
  --grpc-swift_out=../../../Gen \
  --grpc-swift_opt=Client=true,Visibility=Public \
  --proto_path=. \
  -I api/proto \
  -I attest/api/proto \
  -I consensus/api/proto \
  -I fog/api/proto \
  -I fog/report/api/proto \
  external.proto \
  blockchain.proto \
  printable.proto \
	quorum_set.proto \
  watcher.proto \
  attest.proto \
  consensus_client.proto \
  consensus_common.proto \
  consensus_config.proto \
  report.proto \
  fog_common.proto \
  kex_rng.proto \
  ledger.proto \
  view.proto \
  legacyview.proto

echo "complete"
echo ""
echo ""

cat ../../../Gen/attest.http.swift
cat ../../../Gen/consensus_client.http.swift

 cp ../../../Gen/attest.http.swift ../../../Gen/consensus_client.http.swift ../../../Gen/consensus_common.http.swift ../../../Gen/ledger.http.swift ../../../Gen/report.http.swift ../../../Gen/view.http.swift /Users/Shared/MobileCoin-Swift-MobileDev/Sources/Network/HTTPS/HttpConnection/HttpConnections/HttpProtoGenerated
