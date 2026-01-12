# ===============================
# Actualizar yt-dlp
# ===============================
pip install --upgrade yt-dlp

# ===============================
# Archivo con enlaces
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
            --cookies "C:\tools\cookies.txt" `
            --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" `
            --referer "https://player.vimeo.com/" `
            --add-header "Accept-Language:en-US,en;q=0.9" `
            -f "bv*[height<=720]+ba/b" `
            -o $output `
            $url

        if ($LASTEXITCODE -ne 0) {
            Write-Host "❌ No se pudo descargar el video (privado / protegido)" -ForegroundColor Red
        }

        continue
    }

    else {
        Write-Host "=== Descargando YouTube ===" -ForegroundColor Green

        yt-dlp `
            -f "bestvideo+bestaudio" `
            --merge-output-format mp4 `
            -o $output `
            $url
    }
}
