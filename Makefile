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

### Testing ####################################################################

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
