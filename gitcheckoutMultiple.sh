#!/bin/bash

#Autor: Seth Karim Luis Martínez
#Descripción: Este script ejecuta el comando 'git checkout' a todos los directorios configurados en el archivo 'proyects.config'.
#Uso: Este script puede ejecutarse en el directorio que contenga los directorios configurados en 'proyects.config'.
#Configuración: El archivo 'proyects.config' debe existir en el mismo directorio donde se encuentre este script  y debe contener una lista de los nombres de los directorios en los cuales se desea ejecutar este script. Los nombres que comiencen con el caracter '#' serán ignorados. Es recomendable que antes de ejecutar este script se verifique no existan archivos sin comitir en alguno de los directorios configurados en 'proyects.config' ya que de existir archivos sin comitir el cambio de branch no se llevará a cabo.
#Parámetros: 1- Nombre del branch

#Variables
BRANCH=$1
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

echo "Cambiando ${#PROYECTOS[@]} al branch $BRANCH ..."

for proyecto in ${PROYECTOS[@]}
do
	cd "$proyecto"
	echo "Cambiando al branch $BRANCH el proyecto $proyecto ..."
	git checkout "$BRANCH"
	echo -e "\n"
	cd ..
done