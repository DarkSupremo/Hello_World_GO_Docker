# https://www.cloudreach.com/en/resources/blog/cts-build-golang-dockerfiles/
FROM golang:1.14-alpine as builder
RUN mkdir /build
ADD ./src /build/
WORKDIR /build
RUN go build -o main .

FROM alpine
RUN adduser -S -D -H -h /app appuser
USER appuser
COPY --from=builder /build/main /app/
WORKDIR /app
CMD ["./main"]