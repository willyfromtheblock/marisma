# Use latest stable channel SDK.
FROM dart:stable

# Resolve app dependencies.
WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

# Copy app source code (except anything in .dockerignore) and AOT compile app.
COPY . .
RUN dart pub get
RUN dart compile exe bin/marisma.dart -o bin/marisma

# Add libgcc
RUN apt-get update && \
    apt-get -y install libgcc-s1  && \
    rm -rf /var/lib/apt/lists/*

# Start marisma.
CMD ["/app/bin/marisma"]
