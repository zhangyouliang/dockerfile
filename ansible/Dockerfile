FROM alpine:3.5

COPY repositories /etc/apk/repositories
RUN apk add --no-cache ansible py-pip \
    && mkdir /playbook

WORKDIR /playbook

COPY ansible.cfg /etc/ansible/

# ENTRYPOINT ["ansible-playbook"]
CMD ["sh"]
