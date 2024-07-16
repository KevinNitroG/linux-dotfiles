<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [KEVINNITRO LINUX DOTFILES](#kevinnitro-linux-dotfiles)
  - [UTILS](#utils)
    - [Rclone mount](#rclone-mount)
    - [Systemctl](#systemctl)
    - [Fingerprint](#fingerprint)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# KEVINNITRO LINUX DOTFILES

[![GitHub last commit (by committer)](https://img.shields.io/github/last-commit/KevinNitroG/linux-dotfiles?style=for-the-badge&color=FAB387)](../../commits/main)
![GitHub repo size](https://img.shields.io/github/repo-size/KevinNitroG/linux-dotfiles?style=for-the-badge&color=B4BEFE)

---

## UTILS

### Rclone mount

> [!NOTE]
>
> Guide: https://github.com/rclone/rclone/wiki/Systemd-rclone-mount

- Create dir
  ```sh
  mkdir ~/<remote-name>
  ```
- Start service
  ```sh
  systemctl --user start rclone@<remote-name>
  ```
- Enable service _(auto start to mount)_
  ```sh
  systemctl --user enable rclone@<remote-name>
  ```

### Systemctl

- Clean services
  ```sh
  systemctl reset-failed
  ```

### Fingerprint

> [!NOTE]
>
> - Doc from ARCH: https://wiki.archlinux.org/title/fprint
> - Supported devices: https://fprint.freedesktop.org/supported-devices.html
> - My device _(Dell Vostro 14 5410)_: `27c6:639c	Goodix MOC Fingerprint Sensor`
