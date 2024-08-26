FROM maven:3.9.0-amazoncorretto-17 AS build

WORKDIR /app

COPY pom.xml /app

COPY /src /app/src

RUN mvn clean package -DskipTests

FROM openjdk:17-alpine

COPY --from=build /app/target/*.jar /app/app.jar

WORKDIR /app

EXPOSE 8082

ENTRYPOINT ["java","-jar","app.jar"]
