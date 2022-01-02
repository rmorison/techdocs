.PHONY: tools
PROTOC := ./tools/bin/protoc
PROTOC_GRPC := ./tools/bin/protoc-gen-go-grpc
PROTOC_GO_FILES := \
	examples/helloworld/helloworld/helloworld.pb.go \
	examples/helloworld/helloworld/helloworld_grpc.pb.go

%.pb.go: %.proto
	$(PROTOC) --go_out=. --go_opt=paths=source_relative $<
%_grpc.pb.go: %.proto
	$(PROTOC) --go-grpc_out=. --go-grpc_opt=paths=source_relative --plugin=protoc-gen-go-grpc=$(PROTOC_GRPC) $<

all: $(PROTOC_GO_FILES)

tools:
	make -C tools

clean:
	rm -f $(PROTOC_GO_FILES)

distclean: clean
	make -C tools clean
