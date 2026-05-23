PACKAGE := transession
BIN_DIR := bin
RELEASE_BIN := target/release/$(PACKAGE)
BIN := $(BIN_DIR)/$(PACKAGE)
ARGS ?=
TEST ?=

.PHONY: all build run install fmt clippy test test-one check publish-dry-run clean

all: build

build:
	cargo build --release
	mkdir -p $(BIN_DIR)
	cp $(RELEASE_BIN) $(BIN)
	chmod +x $(BIN)

run: build
	./$(BIN) $(ARGS)

install:
	cargo install --path .

fmt:
	cargo fmt --all --check

clippy:
	cargo clippy --all-targets --all-features -- -D warnings

test:
	cargo test

test-one:
	cargo test --test roundtrip $(TEST)

check: fmt clippy test

publish-dry-run:
	cargo publish --dry-run --locked

clean:
	cargo clean
	rm -rf $(BIN_DIR)
