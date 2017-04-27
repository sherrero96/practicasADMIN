#!/bin/bash
#Autores: Sergio Herrero 698521
#	  Alex Oarga Hategan 718123
#Uso: ./practica4.sh [OPCION] [FICHERO_USUARIOS] [FICHEROS_IP]
#OPCION
#   -a	 Añade los usuarios del fichero al sistema
#   -r	 Elimina los usuarios del fichero del sistema
#FICHERO_USUARIOS
#  El fichero, para añadir debe contener por cada linea:
#	user:passwd
#  Para eliminar, puede o no contener la passwd:
#       user
#FICHEROS_IP
#  El fichero debe contener una direccion ip por cada linea
#
#Explicacion:Script para añadir o eliminar los usuarios que hay en el
#            FICHERO_USUARIOS en todas las ips de las maquinas que ha
#            en ficheros_ip

usuario=user
if [ $# -ne 3 ] #Comprobamos si tiene tres parametros
then
	echo "Numero incorrecto de parametros"
	echo "Uso: ./practica4.sh [OPCION] [FICHERO_USUARIOS] [FICHEROS_IPS]"
	exit 1
fi

if [ ! -f "$2" -a ! -f "$3" ] #Comprobamos si existen los dos ficheros
then
	echo "Ficheros inexistentes"
	exit 1
fi

case "$1" in
	"-a") #Opcion añadir usuario
		echo "Añadiendo usuarios..."
		OLDIFS=$IFS #Se guarda el antiguo IFS
		IFS=: #Se cambia por el separador :
		cat "$3" | while read IP #Leemos las IPS del fichero
		do
		   echo "Comprobando si $IP es accesible..."
		   ping -c 1 $IP > /dev/null #Se comprueba si existe la IP
		   if [ $? -eq 0 ]; then #La IP es accesible
			cat "$2" | while read name passwd #Leemos los nombres y passwords del fichero
			do
			ssh $usuario@$IP "sudo egrep "^$name" /etc/passwd > /dev/null " #Comprobamos si existe el usuario
			if [ $? -eq 0 ]; then #Si el usuario ya existe, solo se cambia su pass
				echo "$name ya existe, se va a cambiar su pass"
				ssh $usuario@$IP "echo "$name:$passwd" | sudo chpasswd"
			else #El usuario no existe, se va a crear
		  		ssh $usuario@$IP "sudo useradd -m -U -k"/etc/skel" -K UID_MIN=1000 -K UID_MAX=1500 "$name""
		  		ssh $usuario@$IP "echo "$name:$passwd" | sudo chpasswd"
		  		echo "$name"
			fi
			done
	           else
			echo "ERROR: $IP no es accesible"
		   fi
		done
		IFS=$OLDIFS #Se restaura el IFS
		;;
	"-r") #Opcion eliminar usuario
		echo "Eliminando usuarios..."
		OLDIFS=$IFS
		IFS=:
		cat "$3" | while read IP
		do
           echo "Comprobando si $IP es accesible..."
		   ping -c 1 $IP > /dev/null #Se comprueba si es accesible
		   if [ $? -eq 0 ];then  #Es accesible
			cat "$2" | cut -d: -f1 | while read name passwd
			do
				ssh $usuario@$IP "sudo egrep "^$name" /etc/passwd > /dev/null "
				if [ $? -eq 0 ];then #Si existe el usuario
					ssh $usuario@$IP "sudo usermod -L "$name""
					ssh $usuario@$IP "sudo tar -cf backup-$name.tar -C / home/$name" #Se hace el backup 
					ssh $usuario@$IP "sudo userdel -r "$name""
					echo "$name eliminado"
				else #Si no existe el usuario
					echo "No existe el usuario: $name"
					echo "No se hizo nada"
				fi
			done
	       else
  			echo "ERROR: $IP no es accesible"
           fi
		done
		IFS=$OLDIFS
		;;
	*)
		echo "opcion no correcta"
		exit 1
		;;

esac
