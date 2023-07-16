FROM golang:1.21rc2-alpine3.18 AS builder
WORKDIR /src
COPY src/go.mod ./
# COPY go.sum ./
RUN go mod download
COPY ./src .
RUN GOOS=linux go build -o app .

FROM alpine:3.18
RUN apk --no-cache add ca-certificates
COPY --from=builder /src/app ./
CMD ["./app"]
