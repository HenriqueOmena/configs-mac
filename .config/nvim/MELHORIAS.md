# 📝 Melhorias na Configuração do Neovim

Este documento explica todas as melhorias implementadas na sua configuração do Neovim.

---

## 🗑️ 1. Removida Duplicação de Formatters

### O que foi mudado:
- **Removido:** `none-ls.nvim` (antigo null-ls)
- **Mantido:** `conform.nvim`

### Por quê?
Você tinha dois plugins fazendo a mesma coisa (formatação com Prettier, Stylua, etc). Isso causava:
- Conflitos de formatação
- Lentidão ao salvar arquivos
- Formatação duplicada ou inconsistente

### Como funciona agora:
O `conform.nvim` é mais moderno, rápido e simples. A configuração está em `.config/nvim/lua/configs/conform.lua`:

```lua
formatters_by_ft = {
  lua = { "stylua" },
  css = { "prettier" },
  html = { "prettier" },
  javascript = { "prettier" },
  typescript = { "prettier" },
  -- etc...
}
```

**Formatação automática ao salvar** está ativa com `format_on_save = true`.

---

## 🔧 2. Configurado Lua Language Server (lua_ls)

### O que foi mudado:
- **Antes:** Diagnósticos do Lua completamente desabilitados
- **Agora:** `lua_ls` configurado corretamente

### Por quê?
Desabilitar todos os diagnósticos é muito drástico. Você perdia:
- Avisos sobre erros de sintaxe
- Sugestões de autocompletar
- Documentação ao passar o mouse

### Como funciona agora:
O `lua_ls` está configurado para reconhecer o ambiente do Neovim:

```lua
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }, -- Reconhece 'vim' como global
      },
      workspace = {
        library = {
          vim.fn.expand("$VIMRUNTIME/lua"),
          vim.fn.stdpath("config") .. "/lua",
        },
        checkThirdParty = false, -- Não analisa libs externas (performance)
      },
      telemetry = { enable = false },
    },
  },
})
```

**Resultado:** Você tem LSP funcional para Lua sem warnings chatos sobre `vim` não estar definido.

---

## 🖥️ 3. Corrigidos Mapeamentos do Terminal

### O que foi mudado:
- **Removido:** `<Esc>` para fechar terminal (conflitava com programas)
- **Adicionado:** `<C-x>` para sair do modo terminal

### Por quê?
Mapear `<Esc>` no modo terminal quebrava:
- Vim aninhado (nvim dentro de nvim)
- Programas como `less`, `man`, `htop`
- Navegação em shells (zsh/bash com vi-mode)

### Mapeamentos do terminal agora:
| Atalho | Modo | Função |
|--------|------|--------|
| `<C-\>` | Normal | Abre/fecha terminal flutuante |
| `<C-\>` | Terminal | Fecha o terminal |
| `<C-x>` | Terminal | Sai para modo normal (sem fechar) |
| `<leader>tt` | Normal/Terminal | Alternativa para toggle |

**Exemplo de uso:**
1. Aperte `<C-\>` para abrir terminal
2. Use normalmente
3. `<C-\>` fecha o terminal
4. OU `<C-x>` volta ao modo normal (pode navegar, copiar, etc)

---

## 🌳 4. Adicionados Parsers do Treesitter

### O que foi mudado:
Antes tinha apenas: `vim`, `lua`, `vimdoc`, `html`, `css`

Agora tem também:
- `javascript`
- `typescript`
- `tsx` (React/TypeScript)
- `json`
- `yaml`
- `markdown`
- `markdown_inline`
- `bash`
- `regex`

### Por quê?
Treesitter parsers fornecem:
- **Syntax highlighting** preciso e bonito
- **Indentação inteligente**
- **Navegação de código** (ir para função, classe, etc)
- **Seleção de texto** estrutural

---

## ✨ 5. Highlight on Yank (Feedback Visual)

### O que faz:
Quando você copia texto (`y`, `yy`, `yap`, etc), a área copiada pisca por 200ms.

### Implementação:
```lua
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})
```

**Benefício:** Você vê instantaneamente o que foi copiado, evitando erros.

---

## 🪟 6. Navegação Entre Janelas (Splits)

### Novos atalhos:
| Atalho | Função |
|--------|--------|
| `<C-h>` | Vai para janela à esquerda |
| `<C-j>` | Vai para janela abaixo |
| `<C-k>` | Vai para janela acima |
| `<C-l>` | Vai para janela à direita |

### Redimensionar janelas:
| Atalho | Função |
|--------|--------|
| `<C-Up>` | Aumenta altura |
| `<C-Down>` | Diminui altura |
| `<C-Left>` | Diminui largura |
| `<C-Right>` | Aumenta largura |

**Antes:** Tinha que fazer `<C-w>h`, `<C-w>j`, etc (2 teclas)  
**Agora:** Só `<C-h>`, `<C-j>` (mais rápido!)

---

## 📋 7. Melhor Gestão de Buffers

### Novos atalhos:
| Atalho | Função |
|--------|--------|
| `<S-h>` | Buffer anterior (Shift + h) |
| `<S-l>` | Próximo buffer (Shift + l) |
| `<leader>bd` | Fecha buffer atual |
| `<leader>ba` | Fecha **todos** buffers exceto o atual |

**Dica:** `<leader>ba` é super útil quando você tem muitos arquivos abertos e quer limpar tudo.

---

## 📝 8. Better Indenting (Modo Visual)

### O que mudou:
Antes: Seleciona texto → aperta `>` → perde a seleção  
Agora: Seleciona texto → aperta `>` → mantém a seleção (pode identar múltiplas vezes!)

### Também:
| Atalho | Modo Visual | Função |
|--------|-------------|--------|
| `<` | Visual | Indenta esquerda e mantém seleção |
| `>` | Visual | Indenta direita e mantém seleção |
| `J` | Visual | Move linhas selecionadas para baixo |
| `K` | Visual | Move linhas selecionadas para cima |

**Exemplo:**
```
Seleciona 5 linhas → aperta `>` 3 vezes → linhas são indentadas 3 níveis
```

---

## 🎯 9. Melhor Navegação com Busca

### Centralização automática:
| Atalho | Função |
|--------|--------|
| `n` | Próximo resultado (tela centralizada) |
| `N` | Resultado anterior (tela centralizada) |
| `<C-d>` | Scroll down (centralizado) |
| `<C-u>` | Scroll up (centralizado) |

**Benefício:** O cursor sempre fica no meio da tela, você não perde o contexto.

---

## 🧹 10. Outros Atalhos Úteis

| Atalho | Função |
|--------|--------|
| `<Esc>` | Limpa highlight da busca |
| `<leader>w` | Salva arquivo |
| `<leader>q` | Fecha janela |

### Split behavior melhorado:
```lua
opt.splitright = true  -- Split vertical abre à direita
opt.splitbelow = true  -- Split horizontal abre abaixo
```

**Antes:** Splits abriam em posições estranhas  
**Agora:** Sempre abre onde você espera (direita/abaixo)

---

## 🚀 Como Aplicar as Mudanças

1. **Recarregue o Neovim:**
   ```bash
   nvim
   ```

2. **Sincronize plugins:**
   ```vim
   :Lazy sync
   ```

3. **Instale os novos parsers do Treesitter:**
   ```vim
   :TSUpdate
   ```

4. **Verifique se lua_ls está instalado:**
   ```vim
   :Mason
   ```
   Procure por `lua-language-server` e instale se não estiver.

---

## 🎯 Resumo das Melhorias

✅ **Performance:** Removida duplicação de formatters  
✅ **LSP:** Lua agora tem diagnósticos corretos  
✅ **Terminal:** Mapeamentos que não conflitam  
✅ **Syntax:** Mais parsers do Treesitter  
✅ **UX:** Highlight ao copiar, navegação melhorada  
✅ **Produtividade:** Atalhos para buffers, splits, indentação  

---

## 📚 Recursos para Aprender Mais

- `:help vim.keymap.set` - Documentação de mapeamentos
- `:help lspconfig` - Configuração de LSP
- `:Telescope keymaps` - Ver todos os atalhos disponíveis
- `<leader>ch` - Cheatsheet do NvChad (já tinha isso!)

---

**Criado em:** 2025-12-10  
**Configuração base:** NvChad v2.5
