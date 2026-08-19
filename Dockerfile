FROM rust:1.89-alpine3.20 AS builder
RUN apk add --no-cache musl-dev
WORKDIR /build
COPY Cargo.toml Cargo.lock ./
COPY src ./src
RUN cargo build --release --target x86_64-unknown-linux-musl

FROM gcr.io/distroless/static:nonroot
COPY --from=builder /build/target/x86_64-unknown-linux-musl/release/simple-http-server /usr/local/bin/simple-http-server
USER nonroot:nonroot
WORKDIR /var/www/html
ENTRYPOINT ["/usr/local/bin/simple-http-server"]
