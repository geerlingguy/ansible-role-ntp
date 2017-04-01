#!/bin/bash
#
# Ansible role test shim.
#
# Usage: test.sh [os] [playbook]
#   - [os] = One of the supported distros.
#   = [playbook] = The test playbook to run. (Defaults to test.yml if unset).

# Exit on any individual command failure.
set -e

# Pretty colors.
red='\033[0;31m'
green='\033[0;32m'
neutral='\033[0m'

# TODO: Check to make sure OS is provided.
distro=$1
playbook=${2:-"test.yml"}

## Set up vars for Docker setup.
# CentOS 7
if [ $distro = 'centos7' ]; then
  init="/usr/lib/systemd/systemd"
  opts="--privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro"
# CentOS 6
elif [ $distro = 'centos6' ]; then
  init="/sbin/init"
  opts=""
# Ubuntu 16.04
elif [ $distro = 'ubuntu1604' ]; then
  init="/lib/systemd/systemd"
  opts="--privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro"
# Ubuntu 14.04
elif [ $distro = 'ubuntu1404' ]; then
  init="/sbin/init"
  opts=""
# Ubuntu 12.04
elif [ $distro = 'ubuntu1204' ]; then
  init="/sbin/init"
  opts=""
# Debian 8
elif [ $distro = 'debian8' ]; then
  init="/lib/systemd/systemd"
  opts="--privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro"
# Fedora 24
elif [ $distro = 'fedora24' ]; then
  init="/usr/lib/systemd/systemd"
  opts="--privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro"
fi

# Create a container ID.
container_id=$(mktemp)

# Run the container using the supplied OS.
printf ${green}"Starting Docker container: geerlingguy/docker-$distro-ansible."${neutral}"\n"
docker pull geerlingguy/docker-$distro-ansible:latest
docker run --detach --volume="$PWD":/etc/ansible/roles/role_under_test:rw $opts geerlingguy/docker-$distro-ansible:latest $init > "$container_id"

container_id=$(cat $container_id)

printf "\n"

# Test Ansible syntax.
printf ${green}"Checking Ansible playbook syntax."${neutral}
docker exec --tty $container_id env TERM=xterm ansible-playbook /etc/ansible/roles/role_under_test/tests/$playbook --syntax-check

printf "\n"

# Install requirements if `requirements.yml` is present.
# TODO

printf "\n"

# Run Ansible playbook.
printf ${green}"Running command: docker exec $container_id env TERM=xterm ansible-playbook /etc/ansible/roles/role_under_test/tests/$playbook"${neutral}
docker exec --tty $container_id env TERM=xterm ansible-playbook /etc/ansible/roles/role_under_test/tests/$playbook

# Run Ansible playbook again (idempotence test).
printf ${green}"Running playbook again: idempotence test"${neutral}
idempotence=$(mktemp)
docker exec $container_id ansible-playbook /etc/ansible/roles/role_under_test/tests/$playbook | tee -a $idempotence
tail $idempotence \
  | grep -q 'changed=0.*failed=0' \
  && (printf ${green}'Idempotence test: pass'${neutral}"\n") \
  || (printf ${red}'Idempotence test: fail'${neutral}"\n" && exit 1)

# Kill the Docker container?
printf "Removing Docker container...\n"
docker rm -f $container_id
