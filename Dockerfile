################################
# STEP 1 build executable binary
################################
FROM golang:latest as build

WORKDIR $GOPATH/src/github.com/pnieto/assetscraper
COPY . .
RUN go get -u github.com/golang/dep/...
RUN dep ensure

RUN go build -o /go/bin/assetscraper .

ENTRYPOINT ["/go/bin/assetscraper"]

############################
# STEP 2 build a small image
############################
FROM gcr.io/distroless/base
COPY --from=build /go/bin/assetscraper /
ENTRYPOINT ["/assetscraper"]