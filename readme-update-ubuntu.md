# Update Ubuntu Script

Script de actualización para Ubuntu que permite actualizar paquetes del sistema o cambiar a una versión más reciente.

## Características

- Muestra la versión actual de Ubuntu
- Ofrece opciones para:
  - Actualizar paquetes de la versión actual
  - Verificar y actualizar a una versión más reciente
  - Salir del script
- Compara y muestra la versión anterior y actual
- Limpia paquetes obsoletos y archivos temporales
- Elimina caché y logs antiguos
- Opción de reinicio automático

## Uso

```bash
./update-ubuntu.sh
```

## Requisitos

- Sistema Ubuntu
- Permisos de sudo
- Conexión a internet

## Notas

- El script requiere interacción del usuario para seleccionar opciones
- Se recomienda reiniciar el sistema después de la actualización
- Realiza backup automático de configuraciones importantes