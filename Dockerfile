# Use the official OpenJDK 17 image from the Docker Hub
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the jar file from the host to the working directory in the container
COPY target/pipelinedemo-0.0.1-SNAPSHOT.jar /app/app.jar

# Command to run the application
CMD ["java", "-jar", "app.jar"]
