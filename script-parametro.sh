#!/bin/bash


#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"




 function helpPanel(){
        echo -e "\n ${purpleColour}Uso:${endColour}"
        echo -e "\t ${purpleColour}u)${endColour} ${greenColour}Hacer copia de seguridad de la base de datos${endColour}"
        echo -e "\t ${purpleColour}m)${endColour} ${greenColour}Hacer copia de seguridad de archivos incremental${endColour}"
        echo -e "\t ${purpleColour}h)${endColour} ${greenColour}Panel de ayuda${endColour}\n"
}

if [ $# -eq 0 ]; then
	mostrar_ayuda
	exit 1
fi

while getopts ":umh" opcion; do
	case $opcion in
	u)
	 echo -e " ${greenColour}Hacer copia de seguridad de la base de datos${endColour}\n"

	read -p " Ingrese el usuario mysql:" usuario_mysql
	read -p " Ingrese nombre de la base de datos:" base_de_datos
	read -p " Ingrese contrasena mysql:" contrasena_mysql

        # Nombre de usuario y base de datos MySQL
         # usuario_mysql="usuario_mysql"
         # base_de_datos="nombre_base_de_datos"
         # contrasena_mysql = ""
         # Hacer copia de seguridad de la base de datos con mysqldump
        #mysqldump -u $usuario_mysql -p$contrasena_mysql $base_de_datos > $tmpfile

        #tmpfile =$ (mktemp -q /tmp/dbbackup.XXXXXX.sql || exit 1)
        #tmpfiletgz =$ (mktemp -q /tmp/dbbackup.XXXXXX.sql.tar.gz || exit 1)

	 #tar -czvf $tmpfiletgz $tmpfile;
        #rsync $tmpfiletgz clopez@backups.suratica.es:$destino

	;;

	m)

        read -p "ingrese el origen:" origen
        read -p "ingrese el destino:" destino
        echo -e "${greenColour}Realizando copia de seguridad incremental con origen:${endColour} $origen y destino: $destino...}"



        # Copiar archivos con rsync

        rsync -avz $origen clopez@backups.suratica.es:$destino

	;;

	h)
	 helpPanel
	;;

	\?)
	echo "opcion invalida: -$OPTARG"
	helpPanel
	exit 1
	;;

	esac
	done
