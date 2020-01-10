# STAGE 1: Build
FROM golang:1.11-alpine as build
RUN apk update \
  && apk upgrade \
  && apk add --no-cache git nodejs bash npm

RUN go get -u github.com/jteeuwen/go-bindata/... 
RUN go get github.com/tools/godep

WORKDIR /go/src/github.com/kubernetes-up-and-running/kuard

COPY . .

ENV VERBOSE=0
ENV PKG=github.com/kubernetes-up-and-running/kuard
ENV ARCH=amd64
ENV VERSION=test

RUN build/build.sh

# STAGE 2: Deploy
FROM alpine

USER nobody:nobody
COPY --from=build /go/bin/kuard /kuard

CMD ["/kuard"]

