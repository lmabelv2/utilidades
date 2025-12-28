#!/bin/bash
set -euo pipefail

# Script de actualización para Ubuntu con opción de actualizar versión o cambiar a una más reciente
## Colores para salida más clara
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # Sin color

echo -e "${YELLOW}=== Script de Actualización para Ubuntu ===${NC}"
echo -e "${YELLOW}Versión actual:${NC}"
cat /etc/os-release | grep "PRETTY_NAME" | cut -d'"' -f2
echo ""

# Guardar versión anterior para comparación
VERSION_ANTERIOR=$(cat /etc/os-release | grep "VERSION_ID" | cut -d'"' -f2)

echo -e "${BLUE}¿Qué acción deseas realizar?${NC}"
echo "1) Actualizar paquetes de la versión actual"
echo "2) Verificar y actualizar a una versión más reciente de Ubuntu"
echo "3) Salir"
echo ""

read -r -p "Selecciona una opción [1-3]: " opcion

case $opcion in
    1)
        echo -e "${YELLOW}Actualizando paquetes de la versión actual...${NC}"
        ;;
    2)
        echo -e "${YELLOW}Verificando actualizaciones de versión disponibles...${NC}"
        echo -e "${YELLOW}Versión actual: Ubuntu $VERSION_ANTERIOR${NC}"
        
        # Verificar si hay actualizaciones de versión disponibles
        if command -v do-release-upgrade &> /dev/null; then
            echo -e "${YELLOW}Buscando actualizaciones de versión...${NC}"
            sudo do-release-upgrade -c
            echo ""
            read -r -p "¿Deseas actualizar a la nueva versión? [s/N]: " respuesta
            if [[ $respuesta =~ ^[Ss]$ ]]; then
                echo -e "${YELLOW}Iniciando actualización de versión...${NC}"
                sudo do-release-upgrade
                echo -e "${GREEN}Actualización de versión completada.${NC}"
                echo -e "${YELLOW}Reiniciando el sistema en 10 segundos...${NC}"
                sleep 10
                sudo reboot
                exit 0
            else
                echo -e "${YELLOW}Procediendo con actualización de paquetes de la versión actual...${NC}"
            fi
        else
            echo -e "${YELLOW}No se encontraron actualizaciones de versión o el comando no está disponible.${NC}"
            echo -e "${YELLOW}Procediendo con actualización de paquetes de la versión actual...${NC}"
        fi
        ;;
    3)
        echo -e "${YELLOW}Saliendo del script.${NC}"
        exit 0
        ;;
    *)
        echo -e "${RED}Opción no válida. Saliendo.${NC}"
        exit 1
        ;;
esac

echo -e "${YELLOW}Actualizando lista de paquetes...${NC}"
sudo apt update -y

echo -e "${YELLOW}Ejecutando actualización completa...${NC}"
sudo apt full-upgrade -y

echo -e "${YELLOW}Limpiando paquetes obsoletos...${NC}"
sudo apt autoremove --purge -y
sudo apt autoclean
sudo apt clean

echo -e "${YELLOW}Eliminando archivos temporales y caché no utilizados...${NC}"
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*
sudo journalctl --vacuum-time=7d

# Obtener versión actualizada
VERSION_ACTUAL=$(cat /etc/os-release | grep "VERSION_ID" | cut -d'"' -f2)

echo ""
echo -e "${GREEN}=== Actualización completada ===${NC}"
echo -e "${YELLOW}Versión anterior: Ubuntu $VERSION_ANTERIOR${NC}"
echo -e "${YELLOW}Versión actual: Ubuntu $VERSION_ACTUAL${NC}"

if [[ "$VERSION_ANTERIOR" == "$VERSION_ACTUAL" ]]; then
    echo -e "${GREEN}La versión no ha cambiado (solo se actualizaron los paquetes)${NC}"
else
    echo -e "${GREEN}La versión ha sido actualizada${NC}"
fi

echo ""
echo -e "${YELLOW}¿Deseas reiniciar el sistema ahora?${NC}"
read -r -p "Presiona Enter para reiniciar o Ctrl+C para cancelar... "
sudo reboot