FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    wget \
    curl \
    bwa \
    samtools \
    python3 \
    python3-pip \
    default-jre \
    && rm -rf /var/lib/apt/lists/*

COPY analysis/requirements.txt /tmp/
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt

WORKDIR /workspace

CMD ["/bin/bash"]