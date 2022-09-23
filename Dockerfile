# Use latest stable channel SDK.
FROM dart:stable AS build

# Resolve app dependencies.
WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

# Copy app source code (except anything in .dockerignore) and AOT compile app.
COPY . .
RUN dart pub get
RUN dart compile exe bin/dart_utxo_server.dart -o bin/dart_utxo_server

# Build minimal serving image from AOT-compiled `/dart_utxo_server`
# and the pre-built AOT-runtime in the `/runtime/` directory of the base image.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/dart_utxo_server /app/bin/

# Start dart_utxo_server.
CMD ["/app/bin/dart_utxo_server"]
