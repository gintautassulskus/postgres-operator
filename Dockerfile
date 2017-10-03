#build postgres-operator
FROM golang:1.9.0-stretch

WORKDIR /go/src/github.com/zalando-incubator
RUN git clone https://github.com/zalando-incubator/postgres-operator.git

WORKDIR /go/src/github.com/zalando-incubator/postgres-operator
RUN make tools
RUN make deps
RUN make

#package postgres-operator
#the following is copy-pasted from postgres-operator/docker/Dockerfile
FROM alpine:3.6

# We need root certificates to deal with teams api over https
RUN apk --no-cache add ca-certificates

COPY --from=0 /go/src/github.com/zalando-incubator/postgres-operator/build/* /

ENTRYPOINT ["/postgres-operator"]
