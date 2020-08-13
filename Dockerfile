# Start with a base image containing Java runtime
FROM openjdk:11.0.4-jdk

# Add a volume pointing to /tmp
VOLUME /tmp

# Make port 8080 available to the world outside this container
EXPOSE 8080

# The application's jar file

ARG JAR_FILE=target/demo-0.0.1.jar

# use the value to set the ENV var default

#WORKDIR /root/.jenkins/workspace/ptvn-contract-api_master
COPY ./ ./
# Add the application's jar to the container
ADD ${JAR_FILE} demo.jar

# Run the jar file
ENTRYPOINT ["java","-jar","/demo.jar"]
