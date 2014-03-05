# Ansible Role: NTP

Installs NTP on RHEL/CentOS 6.x.

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `vars/main.yml`):

    ntp_timezone: America/Chicago

Set the timezone for your server.

## Dependencies

None.

## Example Playbook

    - hosts: db-servers
      vars_files:
        - vars/main.yml
      roles:
        - { role: geerlingguy.ntp }

*Inside `vars/main.yml`*:

    ntp_timezone: America/Chicago

## License

MIT / BSD

## Author Information

This role was created in 2014 by Jeff Geerling (@geerlingguy), author of Ansible for DevOps. You can find out more about the book at http://ansiblefordevops.com/, and learn about the author at http://jeffgeerling.com/.
