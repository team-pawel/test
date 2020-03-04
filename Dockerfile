FROM openjdk:8 AS build
ENV APP_HOME=/usr/app/
WORKDIR $APP_HOME
#COPY build.gradle.kts settings.gradle.kts gradlew $APP_HOME
#COPY gradle $APP_HOME/gradle
#RUN chmod +x gradlew
#RUN ./gradlew build || return 0 
COPY . .
RUN chmod +x gradlew
RUN ./gradlew build

FROM openjdk:8
ENV ARTIFACT_NAME=app.jar
ENV APP_HOME=/usr/app/
WORKDIR $APP_HOME
COPY --from=build $APP_HOME/build/libs/*.jar $APP_HOME/ARTIFACT_NAME
EXPOSE 8080
CMD ["java","-jar",$ARTIFACT_NAME]
