# Personal Ubuntu Setup

This repository contains Ansible playbooks to setup my personal (i.e. single-user) Ubuntu machine.

Roughly, the playbook

* installs required software
  * development tools (git, make, FileZilla, vscode)
  * heat and power management (notebooks only)
    * fix suspend when closing the lid
    * enhance battery time
    * configure automatic suspend (on battery)
  * office and multi-media usage (firefox, thunderbird, GIMP, libreoffice)
* provisions configuration
  * allow suspension when using external monitors
  * span workspaces and dock over all displays
  * configure installed software (e.g. keybindings and config files)
* places helpful scripts
  * PDF shrinking
  * image shrinking
  * BASH profile and aliases

There is a full list of supported features in the wiki.

>Note: `apt` is preferred over `snap` where snaps seem considerably less performant or lack of compatibility.

## Prerequisites

1. install Ansible to run playbooks

       sudo apt install ansible

2. copy an inventory and adapt it to your needs, i.e. edit the YAML files to match your mail address etc. (there is a full list of the available configuration options in the wiki)

## Usage

Run

    ansible-playbook -i inventory/<product> setup.yml --ask-become-pass

and restart once the playbook completed successfully.

## Aftercare

There may be final steps required, that have to be performed manually:

* install a proprietary graphics card driver, if needed
* start Dropbox to download the proprietary daemon, login and configure selective sync
* prepare KeePassXC
  * copy required key files from backups
  * install KeePassXC browser plugin(s)
  * enable browser integration for desired browser(s) in KeePassXC
  * restart the browser to register it against KeePassXC
* install [Homebrew on Linux](https://docs.brew.sh/Homebrew-on-Linux) (use a new shell session if you want the user-mode) and run
  * `brew install kubectl helm`

## Next Steps

* setup backupnas
* add brew installation
  * install kubectl and helm
* add startup/suspend hooks to
  * en/disable keyboard light
* [possible?] configure terminator as default for nautilus
