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
