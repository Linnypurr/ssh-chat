FROM golang 

WORKDIR /go/src/ssh-chat/

ADD . /go/src/ssh-chat

EXPOSE 2022

RUN ssh-keygen -t rsa -b 4096 -C "email@email.io" -f /root/.ssh/id_rsa -N ''

RUN /go/src/ssh-chat/install_deps.sh

RUN make build

ENV whitelist config/whitelist
ENV admin config/id_rsa.pub

# TODO: Add these as optional
# If your stuff doesnt work, its because of this /shrug
# Make a folder
 CMD ["./ssh-chat", "--whitelist", "config/whitelist", "--admin", "config/id_rsa.pub"]
