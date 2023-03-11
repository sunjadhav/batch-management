#
# Build stage
#
RUN hostname -I | awk '{print $1}'

FROM maven:3.8.2-jdk-8 AS build
COPY . .
RUN mvn clean package -DskipTests

#
# Package stage
#
FROM openjdk:8-jdk-slim
COPY --from=build /target/batch-management.jar bm.jar
# ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["java","-jar","bm.jar"]
