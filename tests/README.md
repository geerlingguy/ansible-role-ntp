# Ansible Role tests

To run the test playbook(s) in this directory:

  1. Install and start Docker.
  1. Download the test shim (see .travis.yml file for the URL) into `tests/test.sh`.
  1. Make the test shim executable: `chmod +x tests/test.sh`.
  1. Run (from the role root directory) `./tests/test.sh [distro] [optional - playbook]`
