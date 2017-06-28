#!/bin/bash

#Autores: Sergio Herrero Barco 698521
#		  Alex Oarga Hategan 718123
#Uso: ./practica6.sh [IP]
#Explicacion: Script que monitoriza el numero de usuarios, la memoria
# ocupada, el espacio libre, el numero de puertos y el numero de 
# programas en ejecucion de la maquina local en la que se ejecuta el
# script, y de la maquina con ip = IP. el registro de la monitorizacion
# se almacena con logger.

if [ $# -ne 1 ]; then #Si el numero de paramtros es incorrecto
	echo "Numero de parametros incorrecto"
	exit 1
fi

ping -w 1 $1 #Se prueba la conexion enviando un solo paquete a la m.remota

if [ $? -ne 0 ]; then 
	echo "Error de conexion con la mquina remota"
	exit 1

else
	#Primero se guarda la monitorizacion de la maquina local
	logger -p local0.info "Maquina local"

	logger -p local0.info "Numero de usuarios y carga media"
	sudo uptime | logger -p local0.info

	logger -p local0.info "Memoria ocupada y libre, y swap usado"
	sudo free -h | logger -p local0.info

	logger -p local0.info "Espacio ocupado y libre"
	sudo df | logger -p local0.info

	logger -p local0.info "Puertos abiertos y conex. establecidas"
	sudo netstat | logger -p local0.info

	logger -p local0.info "Numero de programas en ejecucion"
	sudo ps | logger -p local0.info

	#Ahora se guarda la monitorizacion de la maquina remota
	logger -p local0.info "Maquina remota"

	logger -p local0.info "Numero de usuarios y carga media"
	ssh user@$1 "sudo uptime" | logger -p local0.info

	logger -p local0.info "Memoria ocupada y libre, y swap usado"
	ssh user@$1 "sudo free -h" | logger -p local0.info

	logger -p local0.info "Espacio ocupado y libre"
	ssh user@$1 "sudo df" | logger -p local0.info

	logger -p local0.info "Puertos abiertos y conex. establecidas"
	ssh user@$1 "sudo netstat" | logger -p local0.info

	logger -p local0.info "Numero de programas en ejecucion"
	ssh user@$1 "sudo ps" | logger -p local0.info
fi

	






