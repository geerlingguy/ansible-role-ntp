# Ansible Role: NTP

Installs NTP on RHEL/CentOS and Debian/Ubuntu.

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

This role was created in 2014 by [Jeff Geerling](http://jeffgeerling.com/), author of [Ansible for DevOps](http://ansiblefordevops.com/).
