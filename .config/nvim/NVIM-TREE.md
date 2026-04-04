# 🌳 Configuração do Nvim-Tree

## O Que Foi Mudado

✅ **Ativado nvim-tree** (estava todo comentado)  
✅ **Ícones de arquivos e pastas** (usando nvim-web-devicons)  
✅ **Largura ajustável automaticamente** (`adaptive_size = true`)  
✅ **Linhas de indentação** para hierarquia visual  
✅ **Integração com Git** (mostra status dos arquivos)  
✅ **Destaque de arquivos abertos**  

---

## 🎨 Recursos Visuais

### Ícones de Pastas
- 📁 **Pasta fechada:** 
- 📂 **Pasta aberta:** 
- ▶ **Seta fechada** (clique para expandir)
- ▼ **Seta aberta** (clique para recolher)

### Ícones de Arquivos
Os ícones variam por tipo de arquivo:
- 📄 `.js`, `.ts` → JavaScript/TypeScript
- ⚛️ `.jsx`, `.tsx` → React
- 🎨 `.css`, `.scss` → Estilos
- 📝 `.md` → Markdown
- ⚙️ `.json`, `.yaml` → Configuração
- E muito mais!

### Status do Git
- ✗ **Modificado** (unstaged)
- ✓ **Staged** (pronto para commit)
- ★ **Novo arquivo** (untracked)
- ➡ **Renomeado**
-  **Deletado**
- ○ **Ignorado** (.gitignore)

### Linhas de Hierarquia
```
├── src/
│   ├── components/
│   │   ├── Button.tsx
│   │   └── Input.tsx
│   └── utils/
└── tests/
```

---

## ⌨️ Atalhos do Nvim-Tree

### Navegação Básica
| Atalho | Ação |
|--------|------|
| `<C-n>` | Abre/fecha o nvim-tree |
| `h` | Fecha pasta (ou vai para pasta pai) |
| `l` | Abre pasta/arquivo |
| `<CR>` (Enter) | Abre pasta/arquivo |
| `?` | Mostra ajuda com TODOS os atalhos |

### Abrir em Splits
| Atalho | Ação |
|--------|------|
| `v` | Abre arquivo em split vertical |
| `s` | Abre arquivo em split horizontal |

### Navegação
| Atalho | Ação |
|--------|------|
| `j` / `k` | Move para cima/baixo |
| `<C-j>` / `<C-k>` | Navega entre irmãos |
| `P` | Vai para o nó pai |
| `K` | Vai para o primeiro nó |
| `J` | Vai para o último nó |

### Operações com Arquivos
| Atalho | Ação |
|--------|------|
| `a` | Criar novo arquivo/pasta |
| `d` | Deletar arquivo/pasta |
| `r` | Renomear arquivo/pasta |
| `x` | Recortar (cut) |
| `c` | Copiar arquivo/pasta |
| `p` | Colar arquivo/pasta |
| `y` | Copiar nome do arquivo |
| `Y` | Copiar path relativo |
| `gy` | Copiar path absoluto |

### Visualização
| Atalho | Ação |
|--------|------|
| `R` | Atualizar/Refresh tree |
| `H` | Mostra/esconde arquivos ocultos |
| `I` | Mostra/esconde arquivos ignorados (git) |
| `E` | Expande toda a árvore |
| `W` | Colapsa toda a árvore |

### Git
| Atalho | Ação |
|--------|------|
| `]c` | Próximo arquivo modificado (git) |
| `[c` | Arquivo modificado anterior (git) |

---

## 🔧 Configurações Personalizadas

### Largura Adaptativa
```lua
view = {
  width = 40,
  adaptive_size = true, -- Ajusta automaticamente
}
```

A janela começa com 40 caracteres de largura, mas **se adapta** ao conteúdo. Se você tiver nomes de arquivo longos, ela expande automaticamente!

### Filtros Inteligentes
```lua
filters = {
  dotfiles = false, -- Mostra .env, .gitignore, etc
  custom = { ".DS_Store", "node_modules", ".git" },
}
```

**O que está oculto:**
- `.DS_Store` (macOS)
- `node_modules/` (pesado)
- `.git/` (não precisa ver)

**O que está visível:**
- `.env`, `.gitignore`, `.eslintrc`, etc (importante!)

### Arquivos Abertos em Destaque
```lua
highlight_opened_files = "name"
```

Arquivos que você já abriu aparecem destacados na árvore (mais fácil de localizar).

---

## 🚀 Como Usar

### 1. Abrir o nvim-tree
```
<C-n>  (Control + n)
```

### 2. Navegar
```
j/k    → move para cima/baixo
h      → fecha pasta ou vai para pai
l      → abre pasta/arquivo
```

### 3. Criar Arquivo/Pasta
```
a      → digita o nome
       → termina com / para criar pasta
       → Ex: components/Button.tsx
```

### 4. Ver Status do Git
Os ícones aparecem automaticamente:
- ✗ = arquivo modificado
- ★ = arquivo novo
- etc

---

## 💡 Dicas Úteis

### Criar Estrutura de Pastas Rapidamente
Aperte `a` e digite o caminho completo:
```
components/forms/inputs/TextInput.tsx
```

Ele cria todas as pastas automaticamente!

### Copiar Path do Arquivo
- `y` → copia só o nome (`Button.tsx`)
- `Y` → copia path relativo (`src/components/Button.tsx`)
- `gy` → copia path absoluto (`/Users/seu-nome/projeto/src/components/Button.tsx`)

Super útil para compartilhar ou fazer imports!

### Navegar Só em Arquivos Modificados (Git)
```
]c   → próximo arquivo modificado
[c   → arquivo modificado anterior
```

Perfeito durante code review ou antes de fazer commit!

### Atualizar Tree Automaticamente
O tree já atualiza sozinho quando você cria/deleta arquivos externamente (terminal, IDE, etc). Mas se precisar forçar refresh:
```
R
```

---

## 🎯 Comparação Antes vs Agora

### Antes
- ❌ Sem ícones de arquivos
- ❌ Sem ícones de pastas
- ❌ Largura fixa (nomes cortados)
- ❌ Difícil ver hierarquia
- ❌ Sem status do git

### Agora
- ✅ Ícones bonitos e informativos
- ✅ Ícones de pastas coloridos
- ✅ Largura adaptativa (nomes completos)
- ✅ Linhas de hierarquia visual
- ✅ Status do git integrado
- ✅ Arquivos abertos destacados

---

## 🛠️ Aplicar as Mudanças

1. **Abra o Neovim:**
   ```bash
   nvim
   ```

2. **Sincronize os plugins:**
   ```vim
   :Lazy sync
   ```

3. **Reinicie o Neovim**

4. **Abra o nvim-tree:**
   ```
   <C-n>
   ```

Você deve ver ícones, cores, e nomes completos agora! 🎉

---

## 🐛 Troubleshooting

### Não estou vendo ícones
Você precisa de uma **Nerd Font** instalada:
1. Baixe: https://www.nerdfonts.com/
2. Instale uma fonte (ex: JetBrainsMono Nerd Font)
3. Configure seu terminal para usar ela

No **Ghostty** (seu terminal):
```
font-family = "JetBrainsMono Nerd Font"
```

### Largura ainda está cortando nomes
Aumente a largura inicial:
```lua
view = {
  width = 50, -- ou 60
}
```

### Quer esconder arquivos ocultos por padrão
```lua
filters = {
  dotfiles = true, -- oculta .env, .gitignore, etc
}
```

Você pode alternar com `H` dentro do nvim-tree!

---

**Criado em:** 2025-12-10  
**Plugin:** nvim-tree.lua + nvim-web-devicons
