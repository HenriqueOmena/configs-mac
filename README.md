# 🌟 Dotfiles Setup Documentation

This document outlines the steps and tools included in the dotfiles setup. It serves as a guide to understand the 🛠️ packages being installed and how to set up a new machine using the provided script.

---

## **✨ Overview**

The `dotfiles` repository automates the setup of your development environment. It includes:

1. **📝 Configuration Files:**
   - `~/.config/nvim` for 🖋️ Neovim.
   - `~/.config/ghostty` for 👻 Ghostty.
   - `~/.tmux.conf` for 🖥️ Tmux.
2. **📦 Package Installation:**
   - Essential CLI tools (Formulae ⚙️).
   - GUI applications (Casks 🖼️).
3. **🔗 Symlinks:**
   - Links are created to connect system configuration paths to the `dotfiles` repository.
4. **🤖 Script for Automation:**
   - A `setup.sh` script simplifies 🖱️ installation on a new machine.

---

## **📦 Packages Installed**

### **⚙️ Formulae (Command-Line Tools)**

The following tools are installed using 🏠 Homebrew:

- 🖋️ `neovim`: Modern text editor.
- 🖥️ `tmux`: Terminal multiplexer.
- 🔍 `fzf`: Command-line fuzzy finder.
- 🚀 `ripgrep`: Fast file searching tool.
- 🐙 `gh`: GitHub CLI.
- 🌳 `git`: Version control.
- 🐍 `python`: Python 3 programming language.
- 👀 `watchman`: File watching service.
- 🌈 `tree-sitter`: Syntax parsing library.
- 🐚 `zsh`: Zsh shell.
- 📂 `yazi`: File manager.
- 🎛️ `lazygit`: Git TUI.

### **🖼️ Casks (GUI Applications)**

The following applications are installed via Homebrew Casks:

- 📅 `meetingbar`: Manage meetings from the macOS menu bar.
- 🔄 `alt-tab`: Window switching similar to Windows.
- 🖼️ `notchnook`: Utilities for Macs with a notch.
- ⚡ `raycast`: Productivity tool with powerful extensions.
- 🖼️ `tiles`: Window management for macOS.
- 👻 `ghostty`: Terminal theming tool.

---

## **🤖 Setup Script (****`setup.sh`****)**

The `setup.sh` script automates the configuration process:

### **1️⃣ Install Homebrew**

If Homebrew is not already installed, the script installs it:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### **2️⃣ Install Packages**

The script installs both Formulae and Casks using Homebrew:

```bash
brew install neovim tmux git curl fzf ripgrep gh python watchman tree-sitter zsh yazi lazygit
brew install --cask meetingbar alt-tab notchnook raycast tiles ghostty
```

### **3️⃣ Clone the ****`dotfiles`**** Repository**

The script clones the `dotfiles` repository into the home directory:

```bash
git clone <URL_TO_YOUR_REPOSITORY> ~/dotfiles
```

### **4️⃣ Create Symlinks**

Symlinks are created to map the `dotfiles` repository to the required system paths:

```bash
ln -sf ~/dotfiles/.config/nvim ~/.config/nvim
ln -sf ~/dotfiles/.config/ghostty ~/.config/ghostty
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
```

---

## **🛠️ Using the Setup Script**

### **Steps to Set Up a New Machine**

1. Clone the `dotfiles` repository:

   ```bash
   git clone https://github.com/HenriqueOmena/configs-mac.git ~/dotfiles
   ```

2. Make the script executable:

   ```bash
   chmod +x ~/dotfiles/setup.sh
   ```

3. Run the script:

   ```bash
   ~/dotfiles/setup.sh
   ```

### **🎯 Expected Outcome**

- 🏠 Homebrew will be installed if not already present.
- All listed Formulae and Casks will be installed.
- Configuration files will be symlinked to their appropriate locations.

---

## **❓ FAQ**

### **1️⃣ Can I add more Formulae or Casks?**

Yes, edit the `setup.sh` script and add the desired packages under the respective sections for Formulae or Casks.

### **2️⃣ How do I update the configurations?**

- Edit the files directly in their original locations (e.g., `~/.config/nvim`).
- Changes will be reflected in the `dotfiles` repository due to symlinks.
- Commit and push updates to the repository:
  ```bash
  cd ~/dotfiles
  git add .
  git commit -m "Update configurations"
  git push
  ```

### **3️⃣ How do I reinstall the setup?**

Simply run the `setup.sh` script on any machine to apply the configuration.


