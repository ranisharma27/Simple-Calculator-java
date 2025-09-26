# Step 1: Build Stage - using base image to compile Java
FROM openjdk:17-jdk-slim AS build

# Set working directory
WORKDIR /app

# Copy source code
COPY Calculator.java .

# Compile Java code
RUN javac Calculator.java

# Package into a runnable JAR
RUN jar cfe Calculator.jar Calculator Calculator.class

# Step 2: Runtime Stage
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy JAR from build stage
COPY --from=build /app/Calculator.jar .

# Run the application
ENTRYPOINT ["java","-jar","Calculator.jar"]
