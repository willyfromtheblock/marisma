# Use latest stable channel SDK.
FROM dart:stable AS build

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

# Build minimal serving image from AOT-compiled `/marisma`
# and the pre-built AOT-runtime in the `/runtime/` directory of the base image.
COPY --from=build /runtime/ /
COPY --from=build /app/bin/marisma /app/bin/

# Start marisma.
CMD ["/app/bin/marisma"]
