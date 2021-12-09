# Personal Ubuntu Setup

This repository contains Ansible playbooks to setup my personal (i.e. single-user) Ubuntu machine.

The setup consists of installing required software and applying useful configuration, including

* development tools
* security tools
* office tools
* power and heat management (notebooks only)

`apt` is preferred over `snap` where snaps are considerably less performant or lack of compatibility.

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
* prepare KeePassXC
  * copy required credentials from backups
  * install KeePassXC browser plugin(s)
  * enable browser integration for desired browser(s) in KeePassXC
  * restart the browser to register it against KeePassXC

## Next Steps

* setup backupnas
* configure OS/GNOME via Ansible
* add brew installation
  * add kubectl and helm installation
* add startup/suspend hooks to
  * en/disable keyboard light
* consider adding slimbookbattery
* [possible?] configure terminator as default for nautilus
