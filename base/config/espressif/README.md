# Installation - fedora

```bash
# eim-cli install

sudo rpm --import https://dl.espressif.com/dl/eim/eim.asc
sudo curl -fsSL https://dl.espressif.com/dl/eim/rpm/eim.repo -o /etc/yum.repos.d/espressif-eim.repo
sudo dnf install eim-cli

# esp-idf install

eim install --config ~/.config/espressif/eim_config.toml
```

# Docs

Link: https://docs.espressif.com/projects/idf-im-ui/en/latest/general_info.html
