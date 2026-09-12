FROM eclipse-temurin:21-jdk-alpine AS build

WORKDIR /app

COPY gradlew build.gradle settings.gradle ./
COPY gradle/ gradle/
COPY src/main/ src/main/

RUN chmod +x gradlew && ./gradlew --no-daemon bootWar

FROM eclipse-temurin:21-jre-alpine

RUN addgroup -S app && adduser -S -G app app

WORKDIR /app

COPY --from=build /app/build/libs/*.war app.war

RUN apk upgrade --no-cache libcrypto3 libssl3 openssl libexpat

USER app

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.war"]
