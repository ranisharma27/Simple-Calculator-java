#step 1:Build Stage -using base image to run java application
FROM openjdk:17-jdk-slim AS build

#going into the directory 
WORKDIR /app

#copy source code 
COPY Calculator.java .

#compile the code
RUN javac Calculator.java

#package into jar file
jar cfe Calculator.jar Calculator Calculator.class

#step2: run app

From openjdk:17-jdk-slim

WORKDIR /app

# copy the files build in build stage
COPY --from=build /app/Calculator.jar .

ENTRYPOINT ["java","-jar","Calculator.java"]