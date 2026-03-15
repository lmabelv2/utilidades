\# yt-dlp en Windows – Configuración correcta con Node.js (EJS)



\## Objetivo



Configurar \*\*yt-dlp en Windows\*\* para descargar videos correctamente desde:



\* YouTube

\* Vimeo

\* Streams HLS (.m3u8)

\* Plataformas educativas como Código Facilito



Resolviendo \*\*JavaScript challenges (EJS)\*\* mediante \*\*Node.js\*\*, sin warnings críticos y funcionando tanto desde consola como desde scripts PowerShell.



\---



\# 1. Requisitos instalados



\## Python



Versión recomendada:



Python 3.11 o superior



Ejemplo instalado:



Python 3.13



Ubicación típica:



```

%APPDATA%\\Python\\Python313\\site-packages

```



\---



\## yt-dlp



Instalación o actualización:



```powershell

pip install -U yt-dlp

```



Verificación:



```powershell

yt-dlp -v

```



\---



\## Node.js



Node.js debe estar disponible en el PATH.



Versiones recomendadas:



\* Node 18 LTS

\* Node 20 LTS



Verificación:



```powershell

node -v

```



Salida esperada:



```

v20.x.x

```



\---



\# 2. Archivo de configuración global (PASO CLAVE)



Ubicación:



```

%APPDATA%\\yt-dlp\\config

```



Ejemplo real:



```

C:\\Users\\mabel\\AppData\\Roaming\\yt-dlp\\config

```



⚠️ Importante



El archivo \*\*no debe tener extensión\*\*.



Correcto:



```

config

```



Incorrecto:



```

config.txt

```



\---



\# Contenido recomendado del archivo config



```

\--js-runtime node

\--remote-components ejs:github

```



Esto permite:



\* usar \*\*Node.js como runtime JavaScript\*\*

\* descargar automáticamente el \*\*solver EJS\*\*

\* resolver challenges modernos de YouTube



\---



\# 3. Funcionamiento esperado



Prueba simple:



```powershell

yt-dlp https://youtu.be/P1mRnXCom9U

```



Salida esperada:



```

\[jsc:node] Solving JS challenges using node

\[info] Downloading 1 format(s)

```



\---



\# 4. Descarga de streams HLS (.m3u8)



Muchas plataformas educativas usan \*\*HLS streaming\*\*.



Ejemplo:



```powershell

yt-dlp "URL\_DEL\_PLAYLIST.m3u8" --merge-output-format mp4

```



yt-dlp descarga todos los fragmentos `.ts` y genera un \*\*MP4 final\*\*.



\---



\# 5. Descarga desde Código Facilito



Los videos usan streaming mediante CDN y requieren enviar un \*\*referer\*\*.



Ejemplo funcional:



```powershell

yt-dlp --referer "https://codigofacilito.com/" --merge-output-format mp4 "URL\_PLAYLIST.m3u8"

```



Sin el referer se produce:



```

HTTP Error 403: Forbidden

```



\---



\# 6. Cómo obtener la URL .m3u8 del video



Algunas plataformas no permiten descargar el video directamente desde la URL de la página.



El video se reproduce mediante \*\*HLS streaming\*\*, usando un archivo `.m3u8`.



\## Paso 1 – Abrir herramientas de desarrollador



Presionar:



```

F12

```



Ir a la pestaña:



```

Network

```



\---



\## Paso 2 – Filtrar tráfico



En el filtro escribir:



```

m3u8

```



\---



\## Paso 3 – Reproducir el video



Presionar \*\*Play\*\* en el reproductor.



Aparecerá una solicitud similar a:



```

playlist.m3u8

```



Ejemplo:



```

https://bun.codigofacilito.com/.../playlist.m3u8

```



Copiar esa URL.



\---



\## Paso 4 – Descargar el video



```powershell

yt-dlp --referer "https://codigofacilito.com/" --merge-output-format mp4 "URL\_M3U8"

```



El proceso:



1\. descarga fragmentos `.ts`

2\. los une automáticamente

3\. genera el MP4 final



\---



\# 7. Descarga desde Vimeo protegido



Algunos videos requieren autenticación.



Para descargarlos se deben exportar \*\*cookies del navegador\*\*.



\---



\## Paso 1 – Iniciar sesión



1\. abrir el sitio donde está el video

2\. iniciar sesión

3\. abrir el video normalmente



\---



\## Paso 2 – Copiar la URL del video



Ejemplo:



```

https://vimeo.com/123456789

```



\---



\## Paso 3 – Exportar cookies



Instalar extensión del navegador:



```

Get cookies.txt

```



Exportar las cookies y guardar:



```

cookies.txt

```



Ejemplo de ubicación:



```

C:\\tools\\cookies.txt

```



\---



\## Paso 4 – Descargar el video



```powershell

yt-dlp --cookies C:\\tools\\cookies.txt URL\_DEL\_VIDEO

```



Ejemplo:



```powershell

yt-dlp --cookies C:\\tools\\cookies.txt https://vimeo.com/123456789

```



Esto permite que \*\*yt-dlp utilice la sesión autenticada del navegador\*\*.



\---



\# 8. Uso desde scripts PowerShell



Los scripts pueden automatizar descargas desde múltiples plataformas.



Ejemplo:



```powershell

yt-dlp -f "bv\*+ba/b" --merge-output-format mp4 -o "$HOME\\Videos\\%(title)s.%(ext)s" $url

```



yt-dlp detecta automáticamente si el archivo ya existe:



```

... has already been downloaded

```



\---



\# 9. Mensajes de advertencia aceptables



Los siguientes mensajes \*\*no indican error\*\*:



```

YouTube is forcing SABR streaming

Some formats have been skipped

Sleeping X seconds as required by the site

```



Son limitaciones impuestas por YouTube.



\---



\# 10. Notas sobre URLs .m3u8



Las URLs `.m3u8` suelen contener parámetros temporales como:



```

expires=

token=

```



Esto significa que:



\* la URL \*\*expira después de cierto tiempo\*\*

\* si la descarga falla, se debe \*\*copiar nuevamente la URL desde el navegador\*\*



\---



\# Estado final esperado



Configuración correcta implica:



\* yt-dlp actualizado

\* Node.js detectado

\* solver EJS activo

\* descarga de streams HLS funcional

\* soporte para Vimeo

\* soporte para Código Facilito

\* scripts PowerShell funcionando correctamente



\---



\# Notas finales



Esta configuración sigue las recomendaciones actuales del proyecto \*\*yt-dlp\*\* para plataformas modernas que utilizan:



\* JavaScript challenges

\* streaming HLS

\* protección CDN



Se recomienda conservar el archivo \*\*config\*\* y los scripts de descarga como respaldo para futuras reinstalaciones.



