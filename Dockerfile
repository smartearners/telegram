FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    git cmake g++ make \
    libssl-dev zlib1g-dev \
    gperf

# clone source
RUN git clone --recursive https://github.com/tdlib/telegram-bot-api.git

WORKDIR /telegram-bot-api

RUN mkdir build
WORKDIR /telegram-bot-api/build

RUN cmake -DCMAKE_BUILD_TYPE=Release ..
RUN cmake --build . --target install

EXPOSE 8081

RUN mkdir /data

CMD telegram-bot-api \
  --api-id=$TELEGRAM_API_ID \
  --api-hash=$TELEGRAM_API_HASH \
  --http-port=$PORT \
  --http-ip-address=0.0.0.0 \
  --local \
  --dir=/data
