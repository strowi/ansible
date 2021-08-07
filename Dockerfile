FROM alpine:3.14
LABEL maintainer="Roman v. Gemmeren <strowi@hasnoname.de>"

RUN apk --update --no-cache add \
        sudo \
        openssl \
        ca-certificates \
        git-crypt \
        gnupg \
        py3-pip \
        py3-setuptools \
        openssh-client \
    && apk --update --no-cache add --virtual build-dependencies \
        curl \
        python3-dev \
        libffi-dev \
        openssl-dev \
        build-base  \
    && pip3 install --upgrade --no-cache-dir \
        wheel \
        cffi \
        pyghmi \
        cryptography==2.8 \
        ansible==3.2.0 \
    && echo "===> Removing package list..." \
    && rm -rf \
        /root/.cache  \
        /var/cache/apk/* \
    && apk del build-dependencies \
    && echo "===> Adding hosts for convenience..." \
    && mkdir -p /etc/ansible \
    && echo 'localhost' > /etc/ansible/hosts

COPY ansible-playbook-wrapper /usr/local/bin/

# default command: display Ansible version
ENTRYPOINT [ "ansible-playbook-wrapper" ]
