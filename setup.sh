#!/bin/bash

# Função para instalar o Homebrew
install_homebrew() {
  if ! command -v brew &> /dev/null; then
    echo "Homebrew não encontrado. Instalando..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "Homebrew já está instalado."
  fi
}

# Função para instalar Formulae (ferramentas de linha de comando)
install_formulae() {
  echo "Instalando Formulae..."
  brew update
  brew install neovim tmux git curl fzf ripgrep gh python watchman tree-sitter zsh yazi lazygit
}

# Função para instalar Casks (aplicativos GUI)
install_casks() {
  echo "Instalando Casks..."
  brew install --cask meetingbar alt-tab notchnook raycast tiles ghostty
}

# Função para instalar plugins do Zsh via GitHub
install_zsh_plugins() {
  echo "Instalando plugins do Zsh..."
  ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
}

# Função para clonar o repositório dotfiles
clone_dotfiles() {
  if [ ! -d "$HOME/dotfiles" ]; then
    echo "Clonando o repositório dotfiles..."
    git clone <URL_DO_REPOSITORIO> "$HOME/dotfiles"
  else
    echo "Repositório dotfiles já existe."
  fi
}

# Função para criar links simbólicos
create_symlinks() {
  echo "Criando links simbólicos..."

  # Certifique-se de que o diretório ~/.config existe
  mkdir -p "$HOME/.config"

  # Criação dos links simbólicos
  ln -sf "$HOME/dotfiles/.config/nvim" "$HOME/.config/nvim"
  ln -sf "$HOME/dotfiles/.config/ghostty" "$HOME/.config/ghostty"
  ln -sf "$HOME/dotfiles/.config/yazi" "$HOME/.config/yazi"
  ln -sf "$HOME/dotfiles/tmux.conf" "$HOME/.tmux.conf"

  echo "Links simbólicos criados com sucesso!"
}

# Função principal
main() {
  install_homebrew
  install_formulae
  install_casks
  install_zsh_plugins
  clone_dotfiles
  create_symlinks

  echo "Configuração concluída com sucesso! 🚀"
}

main

