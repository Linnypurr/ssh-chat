FROM golang 

# Set the working directory to /app
WORKDIR /go/src/ssh-chat/

# Copy the current directory contents into the container at /app
ADD . /go/src/ssh-chat

# Make port 80 available to the world outside this container
EXPOSE 2022

RUN ssh-keygen -t rsa -b 4096 -C "noxor@noxor.io" -f /root/.ssh/id_rsa -N ''

RUN /go/src/ssh-chat/install_deps.sh

RUN make build

ENV whitelist config/whitelist
ENV admin config/id_rsa.pub

# Run app.py when the container launches
 CMD ["./ssh-chat", "--whitelist", "config/whitelist", "--admin", "config/id_rsa.pub"]
