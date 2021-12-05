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

Run

    ansible-playbook -i inventory/<product> setup.yml --ask-become-pass

and restart.

## Aftercare

There may be final steps required, that have to be performed manually:

* install a proprietary graphics card driver, if needed
* configure the OS power settings to your needs
* configure the OS appearance to show the dock on all displays
* configure what is displayed in the top bar via GNOME Tweaks
* configure workspaces to span all displays via GNOME Tweaks
* start Dropbox to download the proprietary daemon, login and configure selective sync
* copy required credentials from backups to access password manager etc.

## Next Steps

* add bash configuration (profile, aliases)
  * https://superuser.com/a/789465
* add SSH config
* setup backupnas
* add brew installation
  * add kubectl and helm installation
  * add kubernetes aliases
* add startup/suspend hooks to
  * en/disable keyboard light
* add convenience scripts to
  * en/disable battery conservation mode
* consider adding slimbookbattery
* [possible?] configure terminator as default for nautilus
