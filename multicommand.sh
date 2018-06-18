#!/bin/bash

#Autor: Seth Karim Luis Martínez
#Descripción: Este script ejecuta el comando recibido por parámetro en todos los directorios configurados en el archivo 'proyects.config'
#Uso: Este script puede ejecutarse en el directorio que contenga los directorios configurados en 'proyects.config'. El comando del parámetro deben ir entre comillas dobles.
#Configuración: El archivo 'proyects.config' debe existir en el mismo directorio donde se encuentre este script  y debe contener una lista de los nombres de los directorios en los cuales se desea ejecutar este script. Los nombres que comiencen con el caracter '#' serán ignorados.
#Parámetros: 1- Comando a ejecutar

#Variables
COMMAND=$1
PROYECTOS=()

getProyects() {
        while IFS=$' \t\n\r' read -r LINE
        do
                if [[ $LINE != *"#"* ]]; then
                        PROYECTOS+=("$LINE")
                fi
                
        done < "proyects.config"
}

getProyects

echo "Ejecutando $COMMAND ..."

for proyecto in ${PROYECTOS[@]}
do
        cd "$proyecto"
        pwd
        $COMMAND
        cd ..
done