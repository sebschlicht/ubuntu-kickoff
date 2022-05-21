# IdeaPad 5i Pro 16IHU6

This document describes the notebook's compatibility with Ubuntu.

Tested on:

* Ubuntu 20.04 LTS
* Ubuntu 21.10

## Hardware

### Integrated Devices

#### Video Card

nVidia X Server Settings allow to select the preferred card.
The integrated Intel card works fine.
Other options (nVidia / nVidia on-demand) were not tested.

#### WiFi / Bluetooth

Supported without additional drivers.
From time to time bluetooth devices may disconnect for a short time or until the devices were restarted (common issue, seen on many different machines).

### Keyboard

#### Fn-Keys

| Key      | Function                | Works              | Notes                     |
| -------- | ----------------------- | ------------------ | ------------------------- |
| F1       | Mute                    | :heavy_check_mark: |
| F2       | Decrease volume         | :heavy_check_mark: |
| F3       | Increase volume         | :heavy_check_mark: |
| F4       | Mute microphone         | :heavy_check_mark: |
| F5       | Decrease brightness     | :heavy_check_mark: |
| F6       | Increase brightness     | :heavy_check_mark: |
| F7       | Toggle external display | :heavy_check_mark: |
| F8       | Flight mode             | :heavy_check_mark: |
| F9       | Settings                | :x:                |
| F10      | Lock                    | :x:                |
| F11      | Task manager (?)        | :x:                |
| F12      | Calculator              | :heavy_check_mark: |
| Esc      | Fn-Lock                 | :heavy_check_mark: |
| Star (?) | Insert                  | :x:                | regular key does not work |
| Cut (?)  | Print screen            | :heavy_check_mark: | regular key does not work |
| Space    | Keyboard light          | :heavy_check_mark: |

#### Key LEDs

Several LEDs are integrated into specific keys on the keyboard, that indicate the status of a particular toggle.
All these LEDs worked out-of-the-box.

| Key      | Indicates |
| -------- | --------- |
| Esc      | Fn-Lock   |
| Caps     | Caps-Lock |
| Num-Lock | Num-Lock  |

#### Keyboard light

The keyboard light supports three modes (off, dark, bright) that can be switched through with a function key.

There is currently no known approach to change it programmatically.
The keyboard light stays on when you suspend the notebook via GNOME.

### Display

After installation, the display shows heavy flickering issues when moving the mouse, when switching between windows, even randomly.
There is a workaround to resolve them.

Supported refresh rates: 60Hz, 120Hz.
Various 16:10/16:9/4:3 resolutions ranging from 800x600 to 2560x1600 available.

#### Resolve flickering

To resolve the flickering issues, install lightdm,

    sudo apt install lightdm

disable PSR

    sudo echo "wayoptions i915 enable_psr=0" > /etc/modprobe.d/i915.conf
    sudo grub-mkconfig -o /boot/grub2/grub.cfg
    sudo update-initramfs -u && sudo update-grub

and restart.

## Software

### Suspend

* suspend and resume work reliably, though the suspension literally takes a minute
* keyboard light stays on when suspended via GNOME but not when suspended by closing the lid
* suspension is prohibited by GNOME when external monitors are connected unless configured otherwise (covered in setup)

## Settings

### Battery conservation

The battery conservation (load battery to max. 60%) can be toggled in the BIOS.

Alternatively, you can write `0` (off) or `1` (on) to `/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode` directly.

### Fan mode

The fan mode can be changed in the BIOS.

Changing the fan mode by writing to `/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/fan_mode` directly did not seem to have an effect.

## Fn-Lock

The Fn-Lock (function of Fn-keys become the default behavior) can be toggled in the BIOS and via a function key.

Alternatively, you can write `0` (off) or `1` (on) to `/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/fn_lock` directly.
