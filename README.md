# RHEL7atsd

This is a Dockerfile for building the Axibase ATSD container on RHEL7 Enterprise software enabled hosts

To build this:

1. Clone this repo
2. Build the container - docker build -t rhel7/atsd .
3. Run the container - docker run -d -P rhel7/atsd
4. Connect to the web UI and follow the instructions
