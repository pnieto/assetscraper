################################
# STEP 1 build executable binary
################################
FROM golang:latest as build

WORKDIR $GOPATH/src/github.com/pnieto/assetscraper
COPY . .
RUN go version && go get -u -v golang.org/x/vgo

RUN vgo install ./...

ENTRYPOINT ["/go/bin/assetscraper"]

############################
# STEP 2 build a small image
############################
FROM gcr.io/distroless/base
COPY --from=build /go/bin/assetscraper /
ENTRYPOINT ["/assetscraper"]