# Dockerfile
# Use an image with CMake installed
FROM gcc:latest

# Install CMake
RUN apt-get update && apt-get install -y cmake

# Copy your files into the specified directory in the image
# and set that as the working location
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp

# Create a build directory and run CMake
RUN mkdir build && cd build && cmake ..

# Build the project with CMake
RUN cd build && make

# This command runs your application, comment out this line to compile only
CMD ["./build/cppplayground"]

LABEL Name=cppplayground Version=0.0.1