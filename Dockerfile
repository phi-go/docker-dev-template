FROM debian:buster

RUN apt-get update && \
    apt-get install -y \
        sudo \
        make \
        python3 \
        python3-pip \
        build-essential \
        lsb-release \
        software-properties-common \
        wget \
        entr \
        python-setuptools && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash user && adduser user sudo && echo -n 'user:user' | chpasswd

# Enable passwordless sudo for users under the "sudo" group
RUN sed -i.bkp -e \
      's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' \
      /etc/sudoers

USER user
WORKDIR /home/user/
ENTRYPOINT [ "bash" ]
