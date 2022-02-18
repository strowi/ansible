# Ansible:5.3.0 in a Container

Mirrored from: <https://gitlab.com/strowi/ansible>

## Docker Image

Should be available on docker and gitlab:

* [strowi/ansible:latest](https://hub.docker.com/repository/docker/strowi/ansible)
* [registry.gitlab.com/strowi/ansible:latest](https://gitlab.com/strowi/ansible)

## Usage

### CLI

Runs ansible-playbook as entrypoint with $@ paramters...

```bash
~> docker run -ti -e PLAYBOOK="play.yml" -e ... registry.gitlab.com/strowi/ansible:latest
```

### docker-compose

```yaml
---
version: '2'

services:
  ansible:
    image: registry.gitlab.com/strowi/ansible:latest
    environment:
      PLAYBOOK: play.yml
      INVENTORY:           # default --connection=local
    volumes:
      - ./:/src
```

### Gitlab Pipeline

```yaml
---
ansible:
  stage: deploy
  image:
    name: registry.gitlab.com/strowi/ansible:latest
    entrypoint: [""]
  variables:
    CI_GPG_PRIVATE_KEY: $CI_GPG_PRIVATE_KEY
    ANSIBLE_CONFIG: ./ansible.cfg
    PLAYBOOK: ./play.yml
  script:
    - ansible-playbook-wrapper
  only:
    - master
```

## Environment Variables

* `REQUIREMENTS`: requirements filename (`/requirements.yml`)
* `PLAYBOOK`: playbook filename (`playbook.yml`)
* `INVENTORY`: inventory filename (`/etc/ansible/hosts`)
* `ANSIBLE_CONFIG`: ansible.cfg filename

* `CI_GPG_PRIVATE_KEY`: GPG Private Key used for git-crypt
