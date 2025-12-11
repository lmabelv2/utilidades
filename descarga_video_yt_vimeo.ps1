# Actualizar yt-dlp
pip install --upgrade yt-dlp

# Ruta con los enlaces
$LinksFile = "C:\Users\mabel\devops\Utilidades\links.txt"
$urls = Get-Content $LinksFile

foreach ($url in $urls) {

    if ($url -match "vimeo\.com") {
    Write-Host "=== Descargando VIMEO en 720p ==="
    yt-dlp --cookies "C:\tools\cookies.txt" `
           -f 'bv*[height<=720]+ba/b[height<=720]' `
           -o "C:\Users\mabel\Videos\%(title)s.mp4" `
           $url
} else {
    Write-Host "=== Descargando YouTube en máximo calidad ==="
    yt-dlp -f "bestvideo+bestaudio" `
           --merge-output-format mp4 `
           -o "C:\Users\mabel\Videos\%(title)s.mp4" `
           $url
}

}
