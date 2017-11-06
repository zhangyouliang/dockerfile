WSO2 Enterprise Integrator Docker Image
==========
[![License (LGPL version 3)](https://img.shields.io/badge/license-GNU%20LGPL%20version%203.0-green.svg?maxAge=2592000)](https://github.com/modoagil/wso2-integrator/blob/master/LICENSE)  [![](https://images.microbadger.com/badges/image/modoagil/wso2-integrator.svg)](https://microbadger.com/images/modoagil/wso2-integrator "Badge by microbadger.com")

WSO2 Enterprise Integrator Docker Image repository. You can see our public registries at [Modo Ágil Public Repositories](https://hub.docker.com/u/modoagil/)

[`openjdk:alpine`](https://hub.docker.com/_/openjdk/) is the base image of this image.

Supported tags and Dockerfile links
---

- `latest`, `6.1.1` [(Dockerfile)](https://github.com/modoagil/wso2-integrator/blob/6.1.1/Dockerfile)
- `6.1.0` [(Dockerfile)](https://github.com/modoagil/wso2-integrator/blob/6.1.0/Dockerfile)
- `6.0.0` [(Dockerfile)](https://github.com/modoagil/wso2-integrator/blob/6.0.0/Dockerfile)

How to use?
---

The following ports may be published:

- 8280
- 8243
- 9443

You can create a container from this image running something like this:

```
docker run -d -p 8280:8280 -p 8243:8243 -p 9443:9443 modoagil/wso2-integrator
```

License
---

This project and its documentation are licensed under the LGPL license. Refer to [LICENCE](https://github.com/modoagil/wso2-integrator/blob/master/LICENCE) for more information.
