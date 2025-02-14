FROM maven:3.8.4-openjdk-17 as BUILD

COPY . /usr/src/app
RUN mvn --batch-mode -DskipTests -f /usr/src/app/pom.xml clean package

FROM openjdk:17-jdk
COPY --from=BUILD /usr/src/app/target/*.jar /opt/target/runner.jar
WORKDIR /opt/target

CMD ["java", "-jar", "runner.jar"]
