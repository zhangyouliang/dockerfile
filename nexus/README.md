### nexus

支持:

Java  Npm Docker Bower Python 等

```
sudo docker run -d \
    --name nexus3 \
    --restart=always \
    -p 8088:8088 \
    -p 8081:8081 \
    -p 5000:5000 \
    -v /var/lib/nexus-data:/nexus-data \
    sonatype/nexus3
```