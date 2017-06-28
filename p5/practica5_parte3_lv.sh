#!/bin/bash
#Autores:	Sergio Herrero 698521
#		Alex Oarga Hategan 718123
#Explicacion: Script que crea o extiende los volumenes logicos y sistemas de
#	      de ficheros que residan en dichos volumenes.
#Uso: ./practica5_parte3_lv.sh

#echo "Introduzca una linea con el formato:"
#echo "nombreGrupoVolumen,nombreVolumenLogico,tamaño,tipoSistemaFicheros,directorioMontaje"
#read entrada

entrada=$1

#Se separan cada apartado
grupo=$(echo "$entrada" | cut -d',' -f1)
logico=$(echo "$entrada" | cut -d',' -f2)
tamanyo=$(echo "$entrada" | cut -d',' -f3)
tipo=$(echo "$entrada" | cut -d',' -f4)
directorio=$(echo "$entrada" | cut -d',' -f5)

if [ -z vgdisplay | grep $grupo ]
then
	echo "No existe el grupo"
	exit 1
fi


if [ -z $(lvdisplay | grep /dev/$grupo/$logico" ") ]
then
	echo "No existe el volumen, se procede a crearlo..."
	#Se crea el volumen logico  en el grupo
	sudo lvcreate -L"$tamanyo" -n "$logico" "$grupo" 
	#Se crean y montan los sistemas de ficheros
	sudo mkfs."$tipo" "$logico"
	#Se crea el directorio
	sudo mkdir "$directorio"
	sudo cat aux=""$logico"	"$directorio" "$tipo" defaults 0 0" >> /etc/fstab
fi


#Se redimensiona el tamaño del volumen
 lvextend -L "+$tamanyo" "$logico"

#Se redimensiona los ficheros
resize2fs "$logico"
