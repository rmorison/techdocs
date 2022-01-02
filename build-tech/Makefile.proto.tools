SHELL=/bin/bash
PROTOC_ARCH := $(if $(PROTOC_ARCH),$(PROTOC_ARCH),linux-x86_64)
PROTOC_VERSION := 3.19.1
PROTOC_ZIP := protoc-$(PROTOC_VERSION)-$(PROTOC_ARCH).zip
PROTOC_URL := https://github.com/protocolbuffers/protobuf/releases/download/v$(PROTOC_VERSION)/$(PROTOC_ZIP)
TOOLS_DIR := $(abspath .)

tools: bin/protoc bin/protoc-gen-go bin/protoc-gen-go-grpc

bin/protoc: downloads/$(PROTOC_ZIP)
	unzip -u $<
	touch $@ # fresh mtime over archive time

downloads/$(PROTOC_ZIP): | downloads
	wget --directory-prefix=downloads "$(PROTOC_URL)"

bin/protoc-gen-go: vendor/google.golang.org/protobuf/cmd/protoc-gen-go/main.go | bin
	cd $(dir $<) && go build -o $(TOOLS_DIR)/$@
vendor/google.golang.org/protobuf/cmd/protoc-gen-go/main.go: vendor

bin/protoc-gen-go-grpc: vendor/google.golang.org/grpc/cmd/protoc-gen-go-grpc/main.go | bin
	cd $(dir $<) && go build -o $(TOOLS_DIR)/$@
vendir/vendor/google.golang.org/grpc/cmd/protoc-gen-go-grpc/main.go: vendor

vendor: tools.go
	go mod vendor

downloads bin:
	mkdir $@

clean:
	rm -rf downloads include bin vendor readme.txt
