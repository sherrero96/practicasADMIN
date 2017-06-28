#!/bin/bash
#Autres: Sergio Herrero 698521
#		 Alex Oarga Hategan 718123
#Explicacion: Comprueba remotamente la situacion de uso y organizacion
# de espacio de disco, volumenes logicos, sistemas de ficheros
# y directorios de montaje.
#Uso : ./practica5_parte2.sh [IP]

if [ $# -ne 1 ] #numero de parametros
then
	echo "Numero incorrecto de parametros"
	echo "USO: ./practica5_parte2.sh [IP]"
	exit 1
fi

echo "Comprobando si IP es accesible..."
ping -c 1 $1 > /dev/null
if [ $? -ne 0 ]; then
	echo "IP no accesible."
	exit 1
else
	echo "	DISCOS DUROS Y SUS TAMANYOS"
	#ip accesible
	ssh user@$1 "sudo sfdisk -s"
	echo "	PARTICIONES  Y TAMANYOS"
	ssh user@$1 "sudo sfdisk -l"
	echo "	INFORMACION DE MONTAJE"
	ssh user@$1 "sudo df -hT"
fi
