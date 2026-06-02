## Multi-stage build: build WAR with Maven, run on Tomcat.
## The deployed WAR filename controls the context path, so we copy it as:
##   webapps/childrentoyweb_war.war
## This ensures the app is available at:
##   http://localhost:8080/childrentoyweb_war/

FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /workspace

# Cache dependencies first
COPY pom.xml ./
RUN mvn -B -q -DskipTests dependency:go-offline

# Build
COPY src ./src
RUN mvn -B -q -DskipTests package

FROM tomcat:10.1.24-jdk17-temurin

# Keep Tomcat's default apps as-is; only add our WAR with the required context path.
COPY --from=build /workspace/target/*.war /usr/local/tomcat/webapps/childrentoyweb_war.war

EXPOSE 8080
