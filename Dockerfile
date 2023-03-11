FROM maven:3.8.2-jdk-8 AS build
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:8-jdk-slim
RUN apt-get update && apt-get install -y iproute2
COPY --from=build /target/batch-management.jar bm.jar
ENV PORT=8080
EXPOSE 8080
CMD ["sh", "-c", "echo 'Docker host IP address:' && /sbin/ip route|awk '/default/ { print $3 }' && java -jar bm.jar"]

