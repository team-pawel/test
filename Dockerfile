FROM openjdk:8 AS build
WORKDIR /usr/app/
COPY . /usr/app/
RUN chmod +x gradlew
RUN ./gradlew build

FROM openjdk:8-jre-alpine
WORKDIR /usr/app/
COPY --from=build /usr/app/build/libs/*.jar /usr/app/app.jar
EXPOSE 8080
CMD ["java","-jar","/usr/app/app.jar"]
