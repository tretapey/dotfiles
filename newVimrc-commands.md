# newVimrc - Comandos Disponibles

> **Nota:** `<Leader>` = `Space` (barra espaciadora)

---

## 📁 Navegación de Archivos

| Comando | Descripción |
|---------|-------------|
| `<Leader>e` | Toggle explorador de archivos en sidebar (Lexplore) |
| `<Leader>f` | Buscar archivo por nombre (con autocomplete) |
| `<Leader>o` | Abrir archivo (lista todos los archivos recursivamente, como Ctrl+p) |
| `<Leader>F` | Buscar en archivos (grep recursivo) |

---

## 💾 Guardar y Salir

| Comando | Descripción |
|---------|-------------|
| `Esc Esc` | Guardar archivo actual |
| `<Leader>q` | Salir del buffer actual |
| `<Leader>Q` | Salir de todos los buffers |
| `<Leader>x` | Guardar y salir |

---

## 📋 Clipboard (Copiar/Pegar)

| Comando | Descripción |
|---------|-------------|
| `<Leader>y` | Copiar selección al clipboard del sistema |
| `<Leader>p` | Pegar desde clipboard del sistema |

---

## 📄 Gestión de Buffers

| Comando | Descripción |
|---------|-------------|
| `<Leader>b` | Lista de buffers (para cambiar) |
| `<Leader>gn` | Buffer siguiente |
| `<Leader>gp` | Buffer anterior |
| `<Leader>gd` | Eliminar buffer actual |

---

## 🗂️ Gestión de Tabs

| Comando | Descripción |
|---------|-------------|
| `<Leader>t` | Nueva tab (con prompt para archivo) |
| `<Leader>1` - `<Leader>9` | Ir a tab 1-9 |

---

## 🪟 Gestión de Ventanas/Splits

| Comando | Descripción |
|---------|-------------|
| `<Leader>w` | Prefijo para comandos de ventana (Ctrl+w) |
| `<Leader>z` | Toggle zoom (maximizar/restaurar ventana actual) |
| `<Leader>=` | Igualar tamaño de todas las ventanas |
| `<Leader>_` | Maximizar ventana actual verticalmente |
| `<Leader>\|` | Maximizar ventana actual horizontalmente |

---

## 🔍 Búsqueda

| Comando | Descripción |
|---------|-------------|
| `<Leader><Space>` | Limpiar resaltado de búsqueda |
| `<Leader>n` | Siguiente resultado de búsqueda |
| `<Leader>N` | Resultado anterior de búsqueda |
| `<Leader>co` | Abrir quickfix list |
| `<Leader>cc` | Cerrar quickfix list |

---

## 💬 Comentarios

| Comando | Descripción |
|---------|-------------|
| `<Leader>/` | Toggle comentario (detecta tipo de archivo automáticamente) |

Funciona en modo normal y visual. Detecta automáticamente:
- JavaScript/TypeScript → `//`
- Python/Bash → `#`
- Vim → `"`
- HTML/XML → `<!--`
- CSS/SCSS → `/*`

---

## 🖥️ Terminal

| Comando | Descripción |
|---------|-------------|
| `` <Leader>` `` | Toggle terminal persistente (abre/cierra) |
| `<Leader>tt` | Abrir terminal |
| `<Leader>tv` | Abrir terminal en split vertical |
| `<Leader>ts` | Abrir terminal en split horizontal |
| `Esc Esc` | Salir del modo terminal (desde terminal) |

---

## 🔧 Git Integration

| Comando | Descripción |
|---------|-------------|
| `<Leader>gs` | Git status |
| `<Leader>gD` | Git diff del archivo actual |
| `<Leader>gb` | Git blame del archivo actual |
| `<Leader>gl` | Git log (últimos 20 commits) |
| `<Leader>ga` | Git add del archivo actual |
| `<Leader>gc` | Git commit |
| `<Leader>gP` | Git push |
| `<Leader>gu` | Git pull |

**Comandos adicionales:**
```vim
:Gstatus   " Git status
:Gdiff     " Git diff del archivo actual
:Gblame    " Git blame del archivo actual
:Glog      " Git log (últimos 10 commits)
```

---

## 📝 Utilidades de Archivo

| Comando | Descripción |
|---------|-------------|
| `<Leader>cd` | Cambiar directorio de trabajo al del archivo actual |
| `<Leader>cp` | Copiar ruta completa del archivo al clipboard |
| `<Leader>cf` | Copiar nombre del archivo al clipboard |
| `<Leader>i` | Mostrar información del archivo actual |

---

## 🎨 Visual y UI

| Comando | Descripción |
|---------|-------------|
| `<Leader>ln` | Toggle números de línea |
| `<Leader>lw` | Toggle line wrap |
| `<Leader>R` | Recargar vimrc |

---

## ⚡ Auto-completado

| Comando | Modo | Descripción |
|---------|------|-------------|
| `Ctrl+Space` | Insert | Omni completion |
| `Ctrl+f` | Insert | Completado de nombres de archivo |
| `Ctrl+l` | Insert | Completado de línea |
| `Tab` | Insert | Siguiente opción en menú de completado |
| `Shift+Tab` | Insert | Opción anterior en menú de completado |
| `Enter` | Insert | Aceptar selección del menú |

---

## 📝 Code Snippets

### JavaScript/TypeScript

| Snippet | Expande a |
|---------|-----------|
| `clog` | `console.log();` |
| `func` | `function() {}` |
| `arrf` | `() => {}` |

### Python

| Snippet | Expande a |
|---------|-----------|
| `pdb` | `import pdb; pdb.set_trace()` |
| `ifmain` | `if __name__ == "__main__":` |

### HTML

| Snippet | Expande a |
|---------|-----------|
| `div<` | `<div></div>` |

---

## 🤖 Claude Code Integration

### Comandos

| Comando | Descripción |
|---------|-------------|
| `:Claude` | Abrir Claude Code interactivamente en terminal |
| `:ClaudeFile [prompt]` | Enviar archivo actual a Claude con prompt opcional |
| `:ClaudeContext` | Abrir Claude con archivo actual como contexto |
| `:ClaudeSelection [prompt]` | Enviar selección a Claude (en modo visual) |
| `:ClaudePrompt <prompt>` | Ejecutar Claude con un prompt específico |
| `:ClaudeEdit [instrucciones]` | Editar código con Claude (muestra resultado para revisar) |
| `:ClaudeApply` | Aplicar último cambio sugerido por Claude |

### Atajos de Teclado

| Comando | Descripción |
|---------|-------------|
| `<Leader>ai` | Abrir Claude Code interactivamente |
| `<Leader>ac` | Abrir Claude con archivo actual como contexto |
| `<Leader>ae` | Editar selección con Claude (modo visual) |
| `<Leader>aa` | Aplicar último cambio de Claude |

### Workflow Ejemplo

1. **Pedir ayuda interactiva:**
   ```
   <Leader>ai     " Abre Claude en terminal
   ```

2. **Preguntar sobre archivo actual:**
   ```
   :ClaudeFile explain this code
   ```

3. **Trabajar con Claude en contexto:**
   ```
   <Leader>ac     " Abre Claude con el archivo cargado
   ```

4. **Editar código con Claude:**
   ```
   (seleccionar código en modo visual)
   <Leader>ae add comments and improve readability
   " Revisar cambios
   <Leader>aa     " Aplicar si te gustan
   ```

5. **Pregunta rápida:**
   ```
   :ClaudePrompt explain async/await in JavaScript
   ```

---

## 🔨 Comandos Útiles Adicionales

| Comando | Descripción |
|---------|-------------|
| `<Leader>j` | Unir línea actual con la siguiente |
| `:FormatJSON` | Formatear JSON en buffer actual |

### En Modo Visual

| Comando | Descripción |
|---------|-------------|
| `<` | Indentar a la izquierda (mantiene selección) |
| `>` | Indentar a la derecha (mantiene selección) |

---

## 📊 Statusline

La barra de estado muestra:
- Modo actual (NORMAL, INSERT, VISUAL, etc.)
- Ruta del archivo
- Flags (modificado, readonly, help)
- Tipo de archivo
- Encoding
- Formato de archivo
- Tamaño del archivo
- Porcentaje de progreso
- Línea:Columna
- **Branch de Git** (si estás en un repositorio)

---

## 🎯 Mejoras Automáticas

- ✅ **Persistent undo** - Historial de cambios guardado entre sesiones
- ✅ **Auto-reload** - Recarga archivos modificados externamente
- ✅ **Cursor position** - Recuerda posición del cursor al reabrir archivos
- ✅ **Backup organizado** - Archivos de backup en `~/.vim/backup`
- ✅ **Swap organizado** - Archivos swap en `~/.vim/swap`
- ✅ **Undo persistente** - Historial en `~/.vim/undo`
- ✅ **Trailing whitespace** - Eliminado automáticamente al guardar (Python, JS, TS)
- ✅ **Guías de columna** - Líneas visuales en columnas 80 y 120
- ✅ **Tree view** - Explorador de archivos en vista de árbol
- ✅ **Statusline mejorada** - Con información de Git y archivo
- ✅ **Tabline personalizada** - Muestra buffers modificados con [+]

---

## 💡 Tips

1. **Explorador de archivos**: Usa `<Leader>e` para toggle rápido del sidebar
2. **Búsqueda rápida**: Usa `<Leader>o` para encontrar cualquier archivo rápidamente
3. **Terminal persistente**: `` <Leader>` `` abre/cierra el mismo terminal (no pierde historial)
4. **Git branch visible**: Mira la statusline para ver en qué branch estás
5. **Comentarios inteligentes**: `<Leader>/` detecta el tipo de archivo automáticamente
6. **Undo infinito**: Puedes deshacer cambios incluso después de cerrar y reabrir vim
7. **Claude integration**: Usa `<Leader>ae` + `<Leader>aa` para editar código con IA

---

## 📚 Recursos

- **Recargar config**: `<Leader>R`
- **Archivo de configuración**: `~/.vimrc` o donde tengas el newVimrc
- **Ayuda de Vim**: `:help` + comando

---

**Última actualización**: 2025-11-04
