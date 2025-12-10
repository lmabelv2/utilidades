#!/bin/bash
set -euo pipefail

# actualiza kali a la ultima version rolling
## Colores para salida más clara
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # Sin color

echo -e "${YELLOW} Iniciando actualización de Kali Linux a la última versión rolling... ${NC}"
echo -e "${YELLOW} Versión actual: ${NC}"
cat /etc/os-release | grep "VERSION="

# (Después del reinicio, podés verificar la versión con:
# cat /etc/os-release | grep "VERSION=")

# Actualizando lista de paquetes ... ${NC}"

echo -e "${YELLOW] Verificando version actual ... ${NC}"
cat /etc/os-release | grep "VERSION="

echo -e "${YELLOW}Configurando repositorios oficiales...${NC}"
sudo bash -c 'cat > /etc/apt/sources.list << EOF
deb http://http.kali.org/kali kali-rolling main non-free non-free-firmware contrib
EOF'

echo -e "${YELLOW}Actualizando lista de paquetes...${NC}"
sudo apt update -y

echo -e "${YELLOW}Ejecutando actualización completa...${NC}"
sudo apt full-upgrade -y

echo -e "${YELLOW}Limpiando paquetes obsoletos...${NC}"
sudo apt autoremove --purge -y
sudo apt clean

echo -e "${GREEN}Actualización completada.${NC}"
echo -e "${YELLOW}Reiniciando el sistema en 10 segundos... (Ctrl+C para cancelar)${NC}"
sleep 10
# Si prefieres confirmación interactiva en lugar de reinicio automático:
read -r -p "Presionar Enter para reiniciar ahora o Ctrl+C para cancelar..."
sudo reboot
# ...existing code...