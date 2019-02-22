FROM maven as build
WORKDIR /build
COPY pom.xml .
RUN mvn verify --fail-never
COPY . .
RUN mvn clean package

FROM openjdk:8
COPY --from=build /build/target/feedback-forms-accounts-0.0.1-SNAPSHOT.jar accounts.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","accounts.jar"]
