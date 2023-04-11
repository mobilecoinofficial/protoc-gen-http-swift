# Which Swift to use.
SWIFT:=swift
# Where products will be built; this is the SPM default.
SWIFT_BUILD_PATH:=./.build
SWIFT_BUILD_CONFIGURATION=debug
SWIFT_FLAGS=--scratch-path=${SWIFT_BUILD_PATH} --configuration=${SWIFT_BUILD_CONFIGURATION}
# Force release configuration (for plugins)
SWIFT_FLAGS_RELEASE=$(patsubst --configuration=%,--configuration=release,$(SWIFT_FLAGS))

# protoc plugins.
PROTOC_GEN_SWIFT=${SWIFT_BUILD_PATH}/release/protoc-gen-swift
PROTOC_GEN_HTTP_SWIFT=${SWIFT_BUILD_PATH}/release/protoc-gen-http-swift

SWIFT_BUILD:=${SWIFT} build ${SWIFT_FLAGS}
SWIFT_BUILD_RELEASE:=${SWIFT} build ${SWIFT_FLAGS_RELEASE}
SWIFT_TEST:=${SWIFT} test ${SWIFT_FLAGS}
SWIFT_PACKAGE:=${SWIFT} package ${SWIFT_FLAGS}

# Name of generated xcodeproj
XCODEPROJ:=HTTP.xcodeproj

### Package and plugin build targets ###########################################

all:
	${SWIFT_BUILD}

Package.resolved:
	${SWIFT_PACKAGE} resolve

.PHONY:
plugins: ${PROTOC_GEN_SWIFT} ${PROTOC_GEN_HTTP_SWIFT}
	cp $^ .

${PROTOC_GEN_SWIFT}: Package.resolved
	${SWIFT_BUILD_RELEASE} --product protoc-gen-swift

${PROTOC_GEN_HTTP_SWIFT}: Sources/protoc-gen-http-swift/*.swift
	${SWIFT_BUILD_RELEASE} --product protoc-gen-http-swift

interop-test-runner:
	${SWIFT_BUILD} --product HTTPInteroperabilityTests

interop-backoff-test-runner:
	${SWIFT_BUILD} --product HTTPConnectionBackoffInteropTest

### Xcodeproj

.PHONY:
project: ${XCODEPROJ}

${XCODEPROJ}:
	${SWIFT_PACKAGE} generate-xcodeproj --output $@
	@-ruby scripts/fix-project-settings.rb HTTP.xcodeproj || \
		echo "Consider running 'sudo gem install xcodeproj' to automatically set correct indentation settings for the generated project."

### Protobuf Generation ########################################################

%.pb.swift: %.proto ${PROTOC_GEN_SWIFT}
	protoc $< \
		--proto_path=$(dir $<) \
		--plugin=${PROTOC_GEN_SWIFT} \
		--swift_opt=Visibility=Public \
		--swift_out=$(dir $<)

%.http.swift: %.proto ${PROTOC_GEN_HTTP_SWIFT}
	protoc $< \
		--proto_path=$(dir $<) \
		--plugin=${PROTOC_GEN_HTTP_SWIFT} \
		--http-swift_opt=Visibility=Public \
		--http-swift_out=$(dir $<)

ECHO_PROTO=Sources/Examples/Echo/Model/echo.proto
ECHO_PB=$(ECHO_PROTO:.proto=.pb.swift)
ECHO_HTTP=$(ECHO_PROTO:.proto=.http.swift)

# For Echo we'll generate the test client as well.
${ECHO_HTTP}: ${ECHO_PROTO} ${PROTOC_GEN_HTTP_SWIFT}
	protoc $< \
		--proto_path=$(dir $<) \
		--plugin=${PROTOC_GEN_HTTP_SWIFT} \
		--http-swift_opt=Visibility=Public,TestClient=true \
		--http-swift_out=$(dir $<)

# Generates protobufs and http client and server for the Echo example
.PHONY:
generate-echo: ${ECHO_PB} ${ECHO_HTTP}

HELLOWORLD_PROTO=Sources/Examples/HelloWorld/Model/helloworld.proto
HELLOWORLD_PB=$(HELLOWORLD_PROTO:.proto=.pb.swift)
HELLOWORLD_HTTP=$(HELLOWORLD_PROTO:.proto=.http.swift)

# Generates protobufs and http client and server for the Hello World example
.PHONY:
generate-helloworld: ${HELLOWORLD_PB} ${HELLOWORLD_HTTP}

ROUTE_GUIDE_PROTO=Sources/Examples/RouteGuide/Model/route_guide.proto
ROUTE_GUIDE_PB=$(ROUTE_GUIDE_PROTO:.proto=.pb.swift)
ROUTE_GUIDE_HTTP=$(ROUTE_GUIDE_PROTO:.proto=.http.swift)

# Generates protobufs and http client and server for the Route Guide example
.PHONY:
generate-route-guide: ${ROUTE_GUIDE_PB} ${ROUTE_GUIDE_HTTP}

NORMALIZATION_PROTO=Tests/HTTPTests/Codegen/Normalization/normalization.proto
NORMALIZATION_PB=$(NORMALIZATION_PROTO:.proto=.pb.swift)
NORMALIZATION_HTTP=$(NORMALIZATION_PROTO:.proto=.http.swift)

# For normalization we'll explicitly keep the method casing.
${NORMALIZATION_HTTP}: ${NORMALIZATION_PROTO} ${PROTOC_GEN_HTTP_SWIFT}
	protoc $< \
		--proto_path=$(dir $<) \
		--plugin=${PROTOC_GEN_HTTP_SWIFT} \
		--http-swift_opt=KeepMethodCasing=true \
		--http-swift_out=$(dir $<)

# Generates protobufs and http client and server for the Route Guide example
.PHONY:
generate-normalization: ${NORMALIZATION_PB} ${NORMALIZATION_HTTP}

### Testing ####################################################################

# Normal test suite.
.PHONY:
test:
	${SWIFT_TEST}

# Normal test suite with TSAN enabled.
.PHONY:
test-tsan:
	${SWIFT_TEST} --sanitize=thread

# Runs codegen tests.
.PHONY:
test-plugin: ${PROTOC_GEN_HTTP_SWIFT}
	PROTOC_GEN_HTTP_SWIFT=${PROTOC_GEN_HTTP_SWIFT} ./dev/codegen-tests/run-tests.sh

### Misc. ######################################################################

.PHONY:
clean:
	-rm -rf Packages
	-rm -rf ${SWIFT_BUILD_PATH}
	-rm -rf ${XCODEPROJ}
	-rm -f Package.resolved
	-cd Examples/Google/NaturalLanguage && make clean
