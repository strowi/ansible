# Ansible in a Container

Runs ansible-playbook as entrypoint with $@ paramters...

```yaml
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

- `CI_GPG_PRIVATE_KEY` GPG Private Key used for git-crypt
