FROM alpine:3.18
LABEL maintainer="Roman v. Gemmeren <strowi@hasnoname.de>"

# renovate: datasource=pypi depName=ansible versioning=loose
ENV ANSIBLE_VERSION="10.2.0"
ENV BUILD_DEPS=" \
  curl \
  python3-dev \
  libffi-dev \
  openssl-dev \
  build-base"

RUN apk --update --no-cache add \
    sudo \
    openssl \
    ca-certificates \
    git-crypt \
    gnupg \
    py3-pip \
    py3-setuptools \
    py3-cryptography \
    openssh-client \
  && apk --update --no-cache add --virtual build-dependencies ${BUILD_DEPS} \
  && pip3 install --upgrade --no-cache-dir \
    cffi \
    pyghmi \
    ansible==${ANSIBLE_VERSION} \
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
