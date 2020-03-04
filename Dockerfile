FROM openjdk:8 AS build
WORKDIR /usr/app/
#COPY build.gradle.kts settings.gradle.kts gradlew $APP_HOME
#COPY gradle $APP_HOME/gradle
#RUN chmod +x gradlew
#RUN ./gradlew build || return 0 
COPY . /usr/app/
RUN chmod +x gradlew
RUN ./gradlew build

FROM openjdk:8
WORKDIR /usr/app/
COPY --from=build /usr/app/build/libs/*.jar /usr/app/app.jar
EXPOSE 8080
CMD ["java","-jar","/usr/app/app.jar"]
