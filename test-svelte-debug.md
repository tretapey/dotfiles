# Debug para archivos .svelte en vim

Abre un archivo `.svelte` en vim y ejecuta estos comandos uno por uno:

## 1. Verificar qué vimrc se está usando:
```vim
:echo $MYVIMRC
```
Debería mostrar la ruta a tu vimrc (ej: `/home/tu-usuario/.vimrc`)

## 2. Verificar si syntax está habilitado:
```vim
:syntax on
```
Esto forzará el syntax highlighting

## 3. Verificar el filetype actual:
```vim
:set filetype?
```
Debería mostrar `filetype=html`

## 4. Verificar si syntax está activo:
```vim
:set syntax?
```
Debería mostrar `syntax=html`

## 5. Forzar el filetype manualmente:
```vim
:set filetype=html
:syntax on
```

## 6. Ver si hay errores:
```vim
:messages
```

## 7. Verificar soporte de colores del terminal:
```vim
:set t_Co?
```
Debería mostrar 256 o más

---

## Solución rápida:

Si no funciona automáticamente, puedes agregar esto al final de tu archivo .svelte:

```
<!-- vim: set filetype=html: -->
```

O dentro de vim, ejecuta:
```vim
:set filetype=html | syntax on
```

---

## ¿Qué resultados obtuviste?

Comparte los resultados de estos comandos para que pueda ayudarte mejor.
