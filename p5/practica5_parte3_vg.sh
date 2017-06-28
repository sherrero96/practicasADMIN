#!/bin/bash
#Autores:	Sergio Herrero 698521
#		Alex Oarga Hategan 718123
#
#Explicacion: Script que extiende la capacidad del volumen dado añadiendo
#             las particiones dadas
#Uso: ./practica5_parte3_vg.sh [volumen] [part 1] ... [part n]

#Comprobamos primero si los parametros son correctos
if [ $# -lt 2 ]
then
	echo "Uso incorrecto"
	echo "Uso: ./practica5_parte3_vg.sh [volumen] [part 1]...[part n]"
	exit 1;
fi

#El volumen dado
volumen=$1
shift #Se desplazan los argumentos para poder iterar

if [ -z $(vgdisplay | grep $volumen" ") ]
then
	for n in $* #Se itera en todas las particiones
	do
		if [ -b "/dev/"$1 ]
		then
			if [ -z $(mount | grep "/dev/"$1" ") ]
			then
				if [ -z $(pvdisplay "/dev/"$1 | grep $volumen) ]
				then
					#Para cada particion
					pvcreate "/dev/"$n  #Se crea un volumen fisico (PV) sobre la particion
					vgextend $volumen "/dev/"$n #Se añade el volumen fisico (PV)  al volumen dado
				else
					echo "Esta partición ya esta añadida"
				fi
			else
				echo "Error particion montada: /dev/$1"
			fi
		else
			echo "No existe la partición /dev/$1"
		fi
	done
else
	echo "Error: Volumen no existe"
fi
