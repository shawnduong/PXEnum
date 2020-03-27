# PXEnum (Post Exploitation Enumeration)

## Overview

A shell script that automatically performs a series of \*NIX enumeration tasks.

## Installation

You can install PXEnum directly by cloning the repository with Git, or you can fetch the source code directly with a tool such as wget if Git is unavailable.

__Cloning with Git__

```
$ git clone https://github.com/shawnduong/PXEnum
```

__Downloading with wget__

```
$ wget https://raw.githubusercontent.com/shawnduong/PXEnum/master/PXEnum.sh
```

## Usage

You can add executability to the shell script and then run it, or you can pass it through the shell interpreter directly.

__Method 1: Adding executability and running__

```
$ chmod +x PXEnum.sh
$ ./PXEnum.sh
```

__Method 2: Passing it through the shell interpreter__

```
$ sh PXEnum.sh
```

## v2.0 (2020.3.27) Changelog

* The source code has been completely revamped to improve readability.
* Got rid of colored text output as it was not universal among shells or terminals. All output is now standard without any colorful gimmicks.
* All checks belonging to a section are now done all at once before being displayed together.
* Moved away from using utilities such as lcpci, lscpu, dmidecode, and they've become less universal and sometimes require elevated privileges. Instead, reading from `/proc` or `/sys` files has been implemented.
* printf alignment has been implemented wherever applicable for easier reading.
* Moved away from cron in favor of systemd timers.
* Moved away from services in favor of systemd services.
* Checks have been revamped. A full list of checks can be found later on in this README.

## Testing, Compatibility, and Contributing

This script was tested on a custom Arch Linux system. Further testing on a multitude of operating systems is needed to ensure compatibility. Please open up an issue if you find bugs.

Contributions are highly welcomed. Please refer to this guide if you are new to Git and/or need some guidance when it comes to making contributions: https://akrabat.com/the-beginners-guide-to-contributing-to-a-github-project/

## Checks

The following is a full list of checks done by PXEnum.

__Basic Information__
* Username
* Hostname
* Home Path
* EUID
* EGID
* Groups
* Kernel Name
* Kernel Release
* Kernel Version
* Architecture
* OS Name

__Hardware Information__
* Product Family
* Product Name
* Product Version
* CPUs and CPU bugs
* RAM Total
* RAM Available
* RAM Free

__BIOS Information__
* BIOS Vendor
* BIOS Date
* BIOS Version

__Users and Groups__
* Users
* Users with login shells
* Users with home directories
* Groups

__Network Information__
* Interfaces
* MAC Addresses
* IP Addresses
* Open Ports

__Activity__
* Currently Online Users
* Currently Running Processes
* Active Services
* Running Services

__Timers__
* Timers

__/etc/shadow Permissions__
* Access
* Owner
* Group

__/etc/sudoers Permissions__
* Access
* Owner
* Group

__Possible SUIDs__
* SUIDs

__sudo History__
* sudo History

__SSH Keys__
* SSH Keys

__Software Versions__
* Bash
* sudo
* GCC
* Python 2
* Python 3
* Java
* cURL
* wget
* Ruby
