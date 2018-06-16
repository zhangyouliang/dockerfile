# dockerfile

已验证完成列表：

| 名称          | 说明             | 备注 |
| ------------- | ---------------- | ---- |
| chanzhieps    | 然之协同Docker版 | N/A  |
| cobbler | Cobbler Docker    | N/A  |
| jenkins     | 增加对宿主机的Docker操作支持 | N/A |
| kafka   | 一键部署Kafka集群|可上生产|
| zookeeper   | 一键部署Zookeeper集群|可上生产|
| maven   | 增加国内仓库地址 |N/A|
| ngrok   | Ngrok Docker |N/A|
| ngrok   | Ngrok Docker |N/A|

```
FROM java:8u111-jdk as builder
COPY . /app
RUN maven /app/file
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest
COPY --from=builder /app/jarfile/
CMD ["./app"]
```