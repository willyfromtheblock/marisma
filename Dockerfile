FROM debian:bookworm-slim AS build

# Install Dart.
RUN apt-get update
RUN apt-get install -y apt-transport-https gnupg2 ca-certificates curl autoconf libtool build-essential git
RUN sh -c 'curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
RUN sh -c 'curl -fsSL https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
RUN apt-get update
RUN apt-get install -y dart

# Build coinlib
# Clone libsecp256k1.
# Could use secp256k1 already in code-base but this makes the dockerfile more
# independent and avoids complexity of copying everything into the correct
# context. It's not a large library to download.
# Use 0.3.1 release
RUN git clone https://github.com/bitcoin-core/secp256k1 \
  && cd secp256k1 \
  && git checkout 346a053d4c442e08191f075c3932d03140579d47

WORKDIR /secp256k1

# Build shared library for linux
RUN ./autogen.sh
RUN ./configure \
  --enable-module-recovery --disable-tests \
  --disable-exhaustive-tests --disable-benchmark \
  CFLAGS="-O2"
RUN make

# Build shared library into /usr/local/lib as usual and then copy into output
# Unused symbols could be stripped. But for future ease, all symbols are
# maintained.
RUN make install
RUN mkdir output
RUN cp /usr/local/lib/libsecp256k1.so.2.0.1 output/libsecp256k1.so

# Create a directory for your app and set it as the working directory.
WORKDIR /app

# Copy and install app dependencies.
COPY pubspec.* ./
RUN dart pub get

# Copy app source code.
COPY . .

# AOT-compile the app.
RUN dart compile exe bin/marisma.dart -o bin/marisma

# Build a minimal serving image from AOT-compiled `/marisma`.
FROM debian:bookworm-slim

# Copy the AOT-compiled binary from the build stage.
COPY --from=build /app/bin/marisma /app/bin/marisma
COPY --from=build /secp256k1/output/libsecp256k1.so /app/bin/libsecp256k1.so

# Start marisma.
CMD ["/app/bin/marisma"]