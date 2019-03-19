################################
# STEP 1 build executable binary
################################
FROM golang:alpine AS builder
RUN apk update && apk add --no-cache git
WORKDIR $GOPATH/src/main/assetscraper
COPY . .
RUN go get -u github.com/gocolly/colly    
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -gcflags="-e" -o /go/bin/assetscraper
ENTRYPOINT ["/go/bin/assetscraper"]

############################
# STEP 2 build a small image
############################
#FROM scratch
#COPY --from=builder /go/bin/assetscraper /go/bin/assetscraper
#ENTRYPOINT ["/go/bin/assetscraper"]
