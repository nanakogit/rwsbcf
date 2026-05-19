FROM alpine:latest

# set version variables for easier maintenance in the future
# sing-box version: https://github.com/SagerNet/sing-box/releases
# cloudflared version: https://github.com/cloudflare/cloudflared/releases
ARG SING_BOX_VERSION=1.10.1
ARG CLOUDFLARED_VERSION=latest

# install necessary download tools and base libraries
RUN apk add --no-cache ca-certificates bash wget tar

WORKDIR /app

# 1. download and install sing-box (corresponding to your web-app)
# download the corresponding amd64 version based on Alpine architecture
RUN wget https://github.com/SagerNet/sing-box/releases/download/v${SING_BOX_VERSION}/sing-box-${SING_BOX_VERSION}-linux-amd64.tar.gz && \
    tar -zxvf sing-box-${SING_BOX_VERSION}-linux-amd64.tar.gz && \
    mv sing-box-${SING_BOX_VERSION}-linux-amd64/sing-box /usr/local/bin/sing-box && \
    rm -rf sing-box-${SING_BOX_VERSION}-linux-amd64*

# 2. download and install cloudflared (corresponding to your sys-service)
RUN wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/${CLOUDFLARED_VERSION}/download/cloudflared-linux-amd64

# 3. copy existing configuration files from your repository (config.json, start.sh, etc.)
COPY . .

# 4. grant execution permissions
RUN chmod +x /usr/local/bin/sing-box && \
    chmod +x /usr/local/bin/cloudflared && \
    chmod +x start.sh

# declare port
EXPOSE 8080

# startup script
CMD ["./start.sh"]
