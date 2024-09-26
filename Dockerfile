# STAGE 1
FROM gradle:jdk21 AS build


WORKDIR /app

COPY settings.gradle .
COPY build.gradle .

COPY src ./src

RUN gradle build --no-daemon

# STAGE 2

FROM openjdk:21-jdk-slim

WORKDIR /app

COPY --from=build /app/build/libs/*.jar discografia.jar

EXPOSE 443 

ENTRYPOINT ["java", "-jar", "discografia.jar"]
