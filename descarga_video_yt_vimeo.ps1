# ===============================
# Forzar UTF-8
# ===============================
chcp 65001 > $null

Write-Host "=== Actualizando herramientas ===" -ForegroundColor Cyan

# ===============================
# Actualizar pip
# ===============================
try {
    python -m pip install --upgrade pip | Out-Null
    Write-Host "✔ pip actualizado" -ForegroundColor Green
}
catch {
    Write-Host "⚠ No se pudo actualizar pip" -ForegroundColor Yellow
}

# ===============================
# Actualizar yt-dlp
# ===============================
try {
    python -m pip install --upgrade yt-dlp | Out-Null
    Write-Host "✔ yt-dlp actualizado" -ForegroundColor Green
}
catch {
    Write-Host "⚠ No se pudo actualizar yt-dlp" -ForegroundColor Yellow
}

# ===============================
# Verificar ffmpeg
# ===============================
if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
    Write-Host "⚠ ffmpeg NO está instalado o no está en el PATH" -ForegroundColor Yellow
    Write-Host "   yt-dlp puede fallar al unir audio/video" -ForegroundColor Yellow
}
else {
    Write-Host "✔ ffmpeg detectado" -ForegroundColor Green
}

# ===============================
# Archivo con enlaces
# recordar que las cookies están en C:\tools\cookies.txt
# ===============================
$LinksFile = "C:\Users\mabel\devops\Utilidades\links.txt"
$urls = Get-Content $LinksFile

# ===============================
# Salida
# ===============================
$output = "C:\Users\mabel\Videos\%(title)s.%(ext)s"

foreach ($url in $urls) {

    Write-Host ""
    Write-Host "Procesando: $url" -ForegroundColor Cyan

    if ($url -match "vimeo\.com") {

        Write-Host "=== Descargando VIMEO (modo protegido) ===" -ForegroundColor Yellow

        yt-dlp `
            --cookies 'C:\tools\cookies.txt' `
            --no-playlist `
            --merge-output-format mp4 `
            -f 'bv*[height<=720]+ba/b' `
            -o $output `
            $url

        if ($LASTEXITCODE -ne 0) {
            Write-Host "❌ No se pudo descargar el video (privado / protegido)" -ForegroundColor Red
        }
        else {
            Write-Host "✅ Descarga completada" -ForegroundColor Green
        }

    }
    else {

        Write-Host "=== Descargando YouTube ===" -ForegroundColor Green

        yt-dlp `
            -f 'bv*+ba/b' `
            --merge-output-format mp4 `
            -o $output `
            $url
    }
}
