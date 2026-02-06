# hspush

A small gRPC push-notification service written in Haskell. It exposes a gRPC API for:
- registering devices for a user
- listing user devices
- sending push messages (FCM backed)

The repo includes:
- Haskell server and a simple Haskell client (`hspush-server`, `hspush-client`)
- SQLite storage layer and migrations
- FCM OAuth/JWT code for Google service accounts

## Components
- Executables:
  - `app/Server.hs` → `hspush-server`
  - `app/Client.hs` → `hspush-client` (example client call)
- Library modules under `src/`:
  - gRPC handlers: `src/Gates/Grpc/Server.hs`
  - storage: `src/Gates/Storage/Sqlite.hs`, `src/Gates/Storage/Migrations.hs`
  - FCM integration: `src/Gates/FCM/Oauth.hs`, `src/Gates/FCM/Push.hs`
- Protobufs: `proto/server.proto` (generated Haskell code under `src/Gates/Grpc/Proto/...`)
- Go load test client: `push_test/` (uses the same `server.proto`)

## Prerequisites
- macOS with Stack installed
- A Google service account JSON key for FCM (placed at `google_secrets.json` or another location)
- SQLite (embedded via `sqlite-easy`, no external server needed)

## Build and test

```bash
# build
stack build

# run tests
stack test
```

If you need a clean build:

```bash
stack clean && stack build
```

## Environment variables
The server reads these at startup (see `src/App.hs`):
- `HSPUSH_SQLITE_DB` — path to the SQLite DB file (e.g. `file.db`)
- `HSPUSH_GOOGLE_SECRETS_FILE` — path to the Google service account JSON (e.g. `./google_secrets.json`)
- `HSPUSH_GOOGLE_ID` — Google project/app ID used in FCM requests
- `HSPUSH_GRPC_PORT` — optional gRPC port to listen on (defaults to `50051`)

## Run the gRPC server

```bash
HSPUSH_SQLITE_DB=file.db \
HSPUSH_GOOGLE_SECRETS_FILE=$(pwd)/google_secrets.json \
HSPUSH_GOOGLE_ID=<your-google-project-id> \
HSPUSH_GRPC_PORT=50051 \
stack run hspush-server
```

The server listens on `0.0.0.0:<port>` where `port` is `HSPUSH_GRPC_PORT` (defaults to `50051`). Logs go to stdout.

## Example: run the Haskell client

```bash
stack run hspush-client
```

The example client sends an `addDevice` call to `127.0.0.1:50051` with a static payload.

## Protobufs
- Source: `proto/server.proto`
- Haskell code is already generated under `src/Gates/Grpc/Proto/` (via `proto-lens`).
- The Go client uses code generated in `push_test/push/v1/`.

If you change `server.proto`, regenerate code accordingly (proto-lens for Haskell, `protoc` + `protoc-gen-go(-grpc)` for Go). See `proto/build.md` for project-specific notes.

## License
BSD-3-Clause
