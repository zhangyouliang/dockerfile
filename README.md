# dockerfile

## Ngrok
内网穿透工具

FROM java:8u111-jdk as builder
COPY . /app
RUN maven /app/file
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest
COPY --from=builder /app/jarfile/
CMD ["./app"]
