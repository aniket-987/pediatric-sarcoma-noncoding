FROM ubuntu:22.04

# Prevents annoying prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    wget \
    curl \
    bwa \
    samtools \
    python3 \
    python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip


COPY requirements.txt /tmp/ 
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt

WORKDIR /data

CMD ["/bin/bash"]
