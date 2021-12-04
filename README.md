# Personal Ubuntu Setup

This repository contains Ansible playbooks to setup my personal (i.e. single-user) Ubuntu machine.

The setup consists of installing required software and applying useful configuration, including

* development tools
* security tools
* office tools

`apt` is preferred over `snap` where snaps are considerably less performant.

## Prerequisites

* install Ansible to run playbooks

      sudo apt install ansible

## Usage

    ansible-playbook -i inventory/<product> setup.yml --ask-become-pass

## Next Steps

* add bash configuration (profile, aliases)
* add brew installation
  * add kubectl and helm installation
* [?] setup backupnas
* add ACPI configuration
  * battery conservation
  * fan mode
* configure terminator as default for nautilus
* add startup/suspend hooks to
  * en/disable keyboard light
  * en/disable battery conservation mode
