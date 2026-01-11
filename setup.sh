#!/bin/bash
source ./btk.sh

# validaciones de programas de terceros
if ! command -v rg >/dev/null 2>&1; then
  log error "La herramienta ripgrep no está instalada. Instálalo antes de continuar" >&2
  exit 1
fi
if ! command -v podman >/dev/null 2>&1; then
  log error "La herramienta podman no está instalada. Instálalo antes de continuar" >&2
  exit 1
fi
# validaciones pre inicio
compose_encontrado=$(ls | rg compose.yml)
if [ -z "$compose_encontrado" ]; then
    log error "No se encontró compose.yml"
    exit 1
fi
# archivo de environment
env_encontrado=$(ls -a | rg .env)
if [ -z "$env_encontrado" ]; then
  log error "No se encontró .env"
  echo "$(lightCyan "  ¿Deseas generar el archivo .env? (y/n)")"
  read -r respuesta
  if [[ "$respuesta" =~ ^[Yy]$ ]]; then
    cp .env.template .env
    echo "$(lightGreen "  Archivo .env generado")"
  else
    log error "Debe generar un archivo .env para el correcto funcionamiento"
    exit 1
  fi
fi

# imprimiendo pasos a seguir
echo "$(bgBlack "$(blue " Pasos para iniciar el proyecto ")")"
echo "$(lightCyan "  Debes ejecutar los siguientes comando en la terminal")"
echo ""
echo "$(blue "$") openssl rand -base64 32 $(lightBlack "# clave para encription key")"
echo "$(blue "$") openssl rand -base64 32 $(lightBlack "# clave para jwt secret")"
echo ""
echo "$(lightCyan "  Abre el editor y mete las claves que creaste en las variables del .env")"
echo ""
echo "$(blue "$") $EDITOR .env"
echo ""
echo "$(lightBlue "  Ahora inicia el contenedor")"
echo ""
echo "$(lightBlue "$") podman-compose up -d"



 
