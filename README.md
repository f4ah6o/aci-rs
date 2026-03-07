# aci

Rust implementation of "Mount APIs as CLIs".

## Modes

- `aci call --url <base_url> [--base-path <path>] <path...> [curl-style flags]`
- `aci [--config aci.toml] <mount> ...`

## Raw fetch flags

- `-X, --method <METHOD>`
- `-H, --header "Key: Value"`
- `-d, --data <json>`
- `--body <json>`
- `--query key=value` (repeatable)
- unknown `--key value` is also treated as query for compatibility

## Config example

```toml
name = "aci"

[[mounts]]
name = "api"
kind = "remote"
base_url = "http://localhost:3000"
base_path = "/api"
openapi = "./openapi.yaml"
timeout_ms = 10_000
```

## OpenAPI mount behavior

- `operationId` becomes command name.
- When `operationId` is missing, a command name is generated from method/path.
- Path params are positional args.
- Query/body fields are `--option value`.
- `raw` subcommand is always available on OpenAPI mounts.
