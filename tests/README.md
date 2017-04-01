# Ansible Role tests

To run the test playbook(s) in this directory:

  1. Install and start Docker.
  1. Download the test shim (see .travis.yml file for the URL) into `tests/test.sh`:
    - `wget -O tests/test.sh https://gist.githubusercontent.com/geerlingguy/73ef1e5ee45d8694570f334be385e181/raw/51ef4c5aea346b3f8dd2c2518233a70dac6407d9/ansible-role-test.sh`
  1. Make the test shim executable: `chmod +x tests/test.sh`.
  1. Run (from the role root directory) `./tests/test.sh [distro] [optional - playbook]`
