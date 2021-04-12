# Ansible in a Container

Runs ansible-playbook as entrypoint with $@ paramters...

```bash
~> docker run -ti -e PLAYBOOK="play.yml" -e ... registry.gitlab.com/strowi/ansible:latest
```

## As Gitlab Job

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

## As docker-compose compoent

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

# Environment Variables

- `REQUIREMENTS`: requirements filename (`/requirements.yml`)
- `PLAYBOOK`: playbook filename (`playbook.yml`)
- `INVENTORY`: inventory filename (`/etc/ansible/hosts`)
- `ANSIBLE_CONFIG`: ansible.cfg filename

- `CI_GPG_PRIVATE_KEY`: GPG Private Key used for git-crypt
