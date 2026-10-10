set shell := ["bash", "-cu"]

fmt:
  cargo fmt --all

fmt-check:
  cargo fmt --all -- --check

clippy:
  cargo clippy --all-targets --all-features -- -D warnings

test:
  cargo test --all --all-features

build:
  cargo build --release --all-features

check: fmt-check clippy test build

release-check:
  cargo test --all --all-features
  cargo build --release --all-features
  cargo publish --dry-run --locked

release: release-check
  @bash -ceu 'set -euo pipefail; \
    git tag -f latest HEAD; \
    git push -f origin latest'
