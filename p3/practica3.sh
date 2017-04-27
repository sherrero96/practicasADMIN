#!/bin/bash
#Autores: Sergio Herrero 698521
#	  Alex Oarga Hategan 718123
#Uso: ./practica3.sh [OPCION] [FICHERO]
#OPCION
#   -a	 Añade los usuarios del fichero al sistema
#   -r	 Elimina los usuarios del fichero del sistema
#FICHERO
#  El fichero, para añadir debe contener por cada linea:
#	user:passwd
#  Para eliminar, puede o no contener la passwd:
#       user
#Explicacion:Script para añadir o eliminar los usuarios que hay en el
#            fichero.

if [ $# -ne 2 ] #Comprobamos si tiene dos parametros
then
	echo "Numero incorrecto de parametros"
	echo "Uso: ./practica3.sh [OPCION] [FICHERO]"
	exit 1
fi

RUTA="$2"
if [ ! -r "$RUTA" ] #Comprobamos si existe y es comun el parametro
then
	echo "Fichero incorrecto"
	exit 1
fi

case "$1" in
	"-a") #Opcion añadir usuario
		echo "Añadiendo usuarios..."
		OLDIFS=$IFS #Se guarda el antiguo IFS
		IFS=: #Se cambia por el separador :
		cat "$RUTA" | while read name passwd
		do
		  useradd -m -U -k"/etc/skel" -K UID_MIN=1000 -K UID_MAX=1500 "$name"
		  echo "$name:$passwd" | chpasswd
		  echo "$name"
		done
		IFS=$OLDIFS #Se restaura el IFS
		;;
	"-r") #Opcion eliminar usuario
		echo "Eliminando usuarios..."
		OLDIFS=$IFS
		IFS=:
		cat "$RUTA" | cut -d: -f1 | while read name passwd
		do
			if [ ! -z "$(grep "$name:" /etc/passwd)" ] #Si existe el usuario
			then
				usermod -L "$name"
				tar -cf backup-$name.tar -C / home/$name #Se hace el backup 
				userdel -r "$name"
				echo "$name eliminado."
			else #Si no existe el usuario
				echo "No existe el usuario: $name"
				echo "No se hizo nada"
			fi
		done
		IFS=$OLDIFS
		;;
	*)
		echo "opcion no correcta"
		exit 1;;

esac
