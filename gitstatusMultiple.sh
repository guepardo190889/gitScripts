#!/bin/bash

#Autor: Seth Karim Luis Martínez
#Descripción: Este script ejecuta el comando 'git status' a todos los directorios configurados en el archivo 'proyects.config' e imprime los resultados en pantalla.
#Uso: Este script puede ejecutarse en el directorio que contenga los directorios configurados en 'proyects.config'.
#Configuración: El archivo 'proyects.config' debe existir en el mismo directorio donde se encuentre este script  y debe contener una lista de los nombres de los directorios en los cuales se desea ejecutar este script. Los nombres que comiencen con el caracter '#' serán ignorados.

#Variables
CHANGES_TO_BE_COMMITTED="Changes to be committed"
CHANGES_NOT_STAGED_FOR_COMMIT="Changes not staged for commit"
UNTRACKED_FILES="Untracked files"
UP_TO_DATE="Your branch is up to date"
MENSAJES=()
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

echo "Verificando ${#PROYECTOS[@]} directorios..."

for proyecto in ${PROYECTOS[@]}
do
	cd "$proyecto"

	OUTPUT="$(git status)"
	AGREGAR_SALTO=false

	if [[ $OUTPUT = *"$CHANGES_TO_BE_COMMITTED"* ]]; then
  		MENSAJES+=("$proyecto : Changes to be committed!")
  		AGREGAR_SALTO=true
	fi

	if [[ $OUTPUT = *"$CHANGES_NOT_STAGED_FOR_COMMIT"* ]]; then
  		MENSAJES+=("$proyecto : Changes not staged for commit!")
  		AGREGAR_SALTO=true
	fi

	if [[ $OUTPUT = *"$UNTRACKED_FILES"* ]]; then
  		MENSAJES+=("$proyecto : Untracked files!")
  		AGREGAR_SALTO=true
	fi

	#if [[ $OUTPUT = *"$UP_TO_DATE"* ]]; then
  	#	MENSAJES+=("$proyecto : Up to date!")
  	#	AGREGAR_SALTO=true
	#fi

	if $AGREGAR_SALTO; then
		MENSAJES+=("\n")
	fi
	
	cd ..
done

#echo ${#MENSAJES[@]}

if [ ${#MENSAJES[@]} -gt 0 ]; then
	for mensaje in "${MENSAJES[@]}"
	do
		echo -e "$mensaje"
	done
else
	echo "Todos tus proyectos están al día!"
fi





