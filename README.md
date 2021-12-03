# Personal Ubuntu Setup

This repository contains Ansible playbooks to setup my personal Ubuntu machine.

The setup consists of installing required software and applying useful configuration, including

* development tools
* security tools
* office tools

`apt` is preferred over `snap` for software where avoiding snaps implies a considerable performance gain.

## Usage

    ansible-playbook -i inventory/<product> setup.yml --ask-become-pass
