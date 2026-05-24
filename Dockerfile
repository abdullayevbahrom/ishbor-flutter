FROM ghcr.io/cirruslabs/flutter:3.44.0

WORKDIR /app

COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

COPY . .

CMD ["flutter", "build", "apk", "--release"]