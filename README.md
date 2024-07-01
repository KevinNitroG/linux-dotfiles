# KEVINNITRO LINUX DOTFILES

[![GitHub last commit (by committer)](https://img.shields.io/github/last-commit/KevinNitroG/linux-dotfiles?style=for-the-badge&color=FAB387)](../../commits/main)
![GitHub repo size](https://img.shields.io/github/repo-size/KevinNitroG/linux-dotfiles?style=for-the-badge&color=B4BEFE)

---

## FCITX5

- Set evironment variables in `.zshrc`
  ```sh
  export XMODIFIERS=@im=fcitx
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
  ```
- GTK setup ...

> [!NOTE]
>
> Ref: [Fcitx 5 Setup](https://fcitx-im.org/wiki/Setup_Fcitx)

## UTILS

### Systemctl

- Clean services
  ```sh
  systemctl reset-failed
  ```
