# yt-dlp en Windows – Configuración correcta con Node.js (EJS)

## Objetivo
Configurar **yt-dlp en Windows** para descargar videos de YouTube correctamente, resolviendo los **JavaScript challenges (EJS)** mediante **Node.js**, sin warnings críticos y funcionando tanto desde consola como desde scripts PowerShell.

---

## 1. Requisitos instalados

### 🟢 Python
- Versión: **Python 3.13**
- Instalación de usuario (sin permisos de administrador)
- Ubicación típica:
```
%APPDATA%\Python\Python313\site-packages
```

---

### 🟢 yt-dlp
Instalación / actualización:
```powershell
pip install -U yt-dlp
```

Verificación:
```powershell
yt-dlp -v
```

---

### 🟢 Node.js
- Node.js instalado y accesible desde el `PATH`
- Recomendado: **Node 18 o 20 LTS** (Node 22 funciona, pero no es LTS)

Verificación:
```powershell
node -v
```

Salida esperada:
```
vXX.X.X
```

---

## 2. Archivo de configuración global (PASO CLAVE)

### 📍 Ubicación
```
%APPDATA%\yt-dlp\config
```

Ruta real de ejemplo:
```
C:\Users\mabel\AppData\Roaming\yt-dlp\config
```

⚠️ El archivo **NO debe tener extensión** (`config`, no `config.txt`).

---

### ✏️ Contenido mínimo requerido

```
--js-runtime node
--remote-components ejs:github
```

Esto permite:
- Usar **Node.js** como runtime JavaScript
- Descargar el **solver EJS oficial** desde GitHub
- Resolver automáticamente los challenges de YouTube

---

## 3. Funcionamiento esperado

### ✅ Comando de prueba
```powershell
yt-dlp https://youtu.be/P1mRnXCom9U
```

### ✅ Salida correcta esperada (ejemplo)
```
[jsc:node] Solving JS challenges using node
[info] Downloading 1 format(s): 299+251
```

Interpretación:
- JS challenges resueltos
- Acceso a formatos de alta calidad
- Descarga de video + audio y posterior merge

---

## 4. Mensajes de advertencia aceptables

Los siguientes warnings **NO indican un problema de configuración**:

- `YouTube is forcing SABR streaming`
- `Some formats have been skipped`
- `Sleeping X seconds as required by the site`

Son limitaciones actuales impuestas por YouTube.

---

## 5. Uso desde scripts PowerShell (.ps1)

- Los scripts que invoquen `yt-dlp` **heredan automáticamente** la configuración global
- No es necesario pasar flags adicionales

Ejemplo:
```powershell
yt-dlp $url -o "$HOME\\Videos\\%(title)s.%(ext)s"
```

Si el archivo ya existe, yt-dlp lo detecta:
```
... has already been downloaded
```

---

## ✅ Estado final esperado

- yt-dlp actualizado y funcional
- Node.js detectado correctamente
- Solver EJS descargado y activo
- Configuración global aplicada
- Descargas HD estables
- Funcionamiento correcto en consola y scripts

---

## Notas finales
Esta configuración es la **recomendada oficialmente** por el proyecto yt-dlp para YouTube a partir de la deprecación de extracción sin runtime JavaScript.

Se recomienda conservar este archivo `config` como respaldo para futuras reinstalaciones.

