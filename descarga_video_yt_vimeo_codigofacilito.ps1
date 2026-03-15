chcp 65001 > $null

Write-Host "=== Actualizando herramientas ===" -ForegroundColor Cyan

try {
    python -m pip install --upgrade pip | Out-Null
    Write-Host "pip actualizado" -ForegroundColor Green
} catch {
    Write-Host "No se pudo actualizar pip" -ForegroundColor Yellow
}

try {
    python -m pip install --upgrade yt-dlp | Out-Null
    Write-Host "yt-dlp actualizado" -ForegroundColor Green
} catch {
    Write-Host "No se pudo actualizar yt-dlp" -ForegroundColor Yellow
}

if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
    Write-Host "ffmpeg NO esta instalado" -ForegroundColor Yellow
} else {
    Write-Host "ffmpeg detectado" -ForegroundColor Green
}

# Archivo con los links
$LinksFile = "C:\Users\mabel\devops\Utilidades\linkscf.txt"
$urls = Get-Content $LinksFile

# Carpeta base
$BaseFolder = "C:\Users\mabel\Videos"

# Carpeta del curso
$CursoNombre = "Curso_CodigoFacilito"
$CursoFolder = Join-Path $BaseFolder $CursoNombre

if (!(Test-Path $CursoFolder)) {
    New-Item -ItemType Directory -Path $CursoFolder | Out-Null
}

$outputDefault = "$BaseFolder\%(title)s.%(ext)s"
$outputCurso   = "$CursoFolder\{0:D2}.mp4"

$index = 1

foreach ($url in $urls) {

    Write-Host ""
    Write-Host "Procesando: $url" -ForegroundColor Cyan

    if ($url -match "vimeo\.com") {

        Write-Host "=== Descargando VIMEO ===" -ForegroundColor Yellow

        yt-dlp `
        --cookies "C:\tools\cookies.txt" `
        --no-playlist `
        --merge-output-format mp4 `
        -f "bv*[height<=720]+ba/b" `
        -o $outputDefault `
        $url

    }
    elseif ($url -match "codigofacilito|\.m3u8|bun\.codigofacilito") {

        Write-Host "=== Descargando Codigo Facilito ===" -ForegroundColor Magenta

        yt-dlp `
        --referer "https://codigofacilito.com/" `
        --merge-output-format mp4 `
        -N 8 `
        -o ($outputCurso -f $index) `
        $url

    }
    else {

        Write-Host "=== Descargando YouTube ===" -ForegroundColor Green

        yt-dlp `
        -f "bv*+ba/b" `
        --merge-output-format mp4 `
        -o $outputDefault `
        $url
    }

    if ($LASTEXITCODE -ne 0) {
        Write-Host "No se pudo descargar el video" -ForegroundColor Red
    } else {
        Write-Host "Descarga completada" -ForegroundColor Green
    }

    $index++
}