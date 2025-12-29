#!/bin/bash
set -euo pipefail

# Actualiza Kali Linux a la última versión rolling
GREEN='\033[0;32m'YELLOW='\033[1;33m'RED='\033[0;31m'NC='\033[0m'

check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "${RED}Este script debe ejecutarse con sudo${NC}"
        exit 1
    fi
}

check_kali() {
    if ! grep -q "Kali" /etc/os-release; then
        echo -e "${RED}Este script es solo para Kali Linux${NC}"
        exit 1
    fi
}

check_internet() {
    if ! ping -c1 http.kali.org &>/dev/null; then
        echo -e "${RED}Sin conexión a internet o repositorio Kali${NC}"
        exit 1
    fi
}

main() {
    check_root
    check_kali
    check_internet

    echo -e "${YELLOW}Iniciando actualización de Kali Linux a la última versión rolling...${NC}"
    
    echo -e "${YELLOW}Versión actual:${NC}"
    cat /etc/os-release | grep "VERSION="

    echo -e "${YELLOW}Creando backup de sources.list...${NC}"
    cp /etc/apt/sources.list /etc/apt/sources.list.bak
    echo -e "${GREEN}✅ Backup creado: /etc/apt/sources.list.bak${NC}"

    echo -e "${YELLOW}Configurando repositorios oficiales Kali...${NC}"
    cat > /etc/apt/sources.list << EOF
deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware
EOF

    echo -e "${YELLOW}Actualizando lista de paquetes...${NC}"
    apt update -y

    echo -e "${YELLOW}Ejecutando dist-upgrade (recomendado por docs oficiales Kali)...${NC}"
    apt dist-upgrade -y

    echo -e "${YELLOW}Limpiando paquetes obsoletos...${NC}"
    apt autoremove --purge -y
    apt autoclean
    apt clean

    echo -e "${GREEN}✅ Actualización completada exitosamente${NC}"
    
    if [[ -f /var/run/reboot-required ]]; then
        echo -e "${YELLOW}🔄 Reinicio requerido detectado (/var/run/reboot-required)${NC}"
    fi

    echo -e "${YELLOW}Presiona Enter para reiniciar ahora o Ctrl+C para cancelar...${NC}"
    read -r
    reboot
}

main "$@"