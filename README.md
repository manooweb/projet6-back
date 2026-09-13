# Workshop Organizer Web API

Welcome to the Workshop Organizer Web API! This application is designed to facilitate workshops open to the public. Whether you’re organizing coding bootcamps, art classes, or any other type of workshop, this API will help manage registrations, schedules, and resources.

## Table of Contents

1. Context
2. Technical Overview
3. Building and Running
4. Configuration
5. Testing
6. Packaging
7. Continuous Integration and Releases

## Context

Workshops play a crucial role in fostering learning and collaboration. Our application aims to streamline the workshop organization process, making it easier for organizers to manage participants, sessions, and materials. Whether you're a seasoned workshop host or just starting out, this API has got you covered!

## Technical Overview

- **Java Development Kit (JDK):** We use **JDK 21**, tested with **Adoptium**, to power our application.
- **Database:** Our backend relies on a **PostgreSQL 18** database for data storage.
- **Build Tool:** We leverage **Gradle 8.7** for managing dependencies and building the project.
- **Spring Boot:** Our application is based on **Spring Boot 3.2.4**, which provides a robust framework for creating RESTful APIs.
- **Application Server:** Our application can run on Tomcat server that require version 10.1.24.

## Building and Running

To compile and run the application locally, follow these steps:

1. Ensure you have JDK 21 installed.
2. Clone this repository.
3. Navigate to the project root directory.
4. Execute the following command to compile the Java code :
   ```bash
   ./gradlew clean compileJava
   ```
5. To run the application locally, either:
   Execute the main method in the Application class from your IDE.
   Use the Spring Boot Gradle Plugin :
   ```bash
   ./gradlew bootRun
   ```
   For production, package the application as WAR and use a tomcat server

After configuring `.env`, start the local Docker stack with:

```bash
docker compose up --build -d
```

The API is available at `http://localhost:8080/`. Stop the local stack with `docker compose down`.

## Configuration

Before starting the application with Docker Compose, copy the example configuration file:

```bash
cp .env.example .env
```

Then set these database environment variables in `.env`:

- `POSTGRES_USER`: Database user name.
- `POSTGRES_PASSWORD`: Database user password.
- `POSTGRES_DB`: Database name.
- `POSTGRES_PORT`: PostgreSQL port. Use `5432` with the current Compose configuration.

Docker Compose derives the Spring Boot datasource settings from these values.

## Testing

To run tests locally, run:

```bash
./gradlew clean test
```

Gradle writes its reports to `build/test-results/test`. For CI, `./run-tests.sh` automatically detects the project type, cleans `test-results/`, runs `./gradlew clean test`, and copies the JUnit XML reports there.

## Packaging

To create a deployable WAR file locally, run:

```bash
./gradlew bootWar
```

The generated WAR can be used with application servers such as Tomcat or WildFly. The CI workflow builds the Docker image directly from the source code.

## Continuous Integration and Releases

GitHub Actions runs tests for pull requests targeting `main` and for pushes to `main`. JUnit reports are available as workflow artifacts and are published in GitHub checks.

Each push builds and publishes a Docker image to GitHub Container Registry:

```text
ghcr.io/manooweb/projet6-back:<branch>-<commit-sha>
```

On `main`, semantic-release creates GitHub releases, Git tags without a `v` prefix, and updates `CHANGELOG.md`, `build.gradle`, `package.json`, and `package-lock.json` when a release-worthy Conventional Commit is pushed. The corresponding Docker image is also tagged with the semantic version, for example:

```text
ghcr.io/manooweb/projet6-back:1.0.0
```

Commits of type `ci:` run the workflow but do not create a release.
