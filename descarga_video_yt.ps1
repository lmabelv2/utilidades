# Actualizar yt-dlp usando pip
pip install --upgrade yt-dlp

# Ruta al archivo TXT con los enlaces de YouTube (cámbiala si es necesario)
$LinksFile = "C:\Users\mabel\devops\Utilidades\links.txt"

# Leer todos los enlaces del archivo txt (uno por línea)
$urls = Get-Content $LinksFile

# Descargar cada video usando yt-dlp
foreach ($url in $urls) {
    yt-dlp -f "bestvideo+bestaudio" -o "C:\Users\mabel\Videos\%(title)s.mp4" --merge-output-format mp4 $url
}
