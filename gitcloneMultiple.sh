#!/bin/bash

#Autor: Seth Karim Luis Martínez
#Descripción: Este script clona ('git clone') todos los repositorios git que se encuentren configurados en 'repositories.config' dentro de las carpetas configuradas en 'proyects.config'
#Uso: Este script puede ejecutarse en el directorio donde se desea clonar los repositorios configurados en 'repositorioes.config'.
#Configuración: Los archivos de configuración 'proyects.config' y 'repositories.config' deben contener la misma cantidad de elementos y corresponderse de tal modo que el primer repositorio configurado en 'repositories.config' deba descargarse en el primer directorio configurado en 'proyects.config' y así sucesivamente. Los nombres que comiencen con el caracter '#' serán ignorados.

#Variables
RUTA_REPOSITORIO_CENTRAL="https://optasmart.repositoryhosting.com/git/optasmart"

PROYECTOS=()
REPOSITORIES=()

getProyects() {
        while IFS=$' \t\n\r' read -r LINE
        do
                if [[ $LINE != *"#"* ]]; then
                        PROYECTOS+=("$LINE")
                fi
                
        done < "proyects.config"
}

getRepositories() {
        while IFS=$' \t\n\r' read -r LINE
        do
                if [[ $LINE != *"#"* ]]; then
                        REPOSITORIES+=("$LINE")
                fi
                
        done < "repositories.config"
}

getProyects
getRepositories

echo "Clonando ${#PROYECTOS[@]} repositorios..."

cont=0
while [ $cont -le ${#PROYECTOS[@]} ] 
do
        if [ "${REPOSITORIES[$cont]}" != "" ]; then
                CLONE="git clone $RUTA_REPOSITORIO_CENTRAL/${REPOSITORIES[$cont]}.git ${PROYECTOS[$cont]}"
                #echo "$CLONE"
	        $CLONE
        fi
        ((cont++))
done

#git clone https://optasmart.repositoryhosting.com/git/optasmart/fbinventarios.git FBInventarios
