#
# Build stage
#
FROM maven:3.8.2-jdk-8 AS build
COPY . .
RUN mvn clean package -DskipTests

#
# Package stage
#
FROM openjdk:8-jdk-slim
COPY --from=build /target/batch-management-0.0.1-SNAPSHOT.jar batch-management.jar
# ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["java","-jar","batch-management.jar"]
