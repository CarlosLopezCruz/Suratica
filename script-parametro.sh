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
        echo -e "\t ${purpleColour}b)${endColour} ${greenColour}Hacer copia de seguridad de la base de datos${endColour}"
        echo -e "\t ${purpleColour}s)${endColour} ${greenColour}Hacer copia de seguridad de archivos incremental${endColour}"
        echo -e "\t ${purpleColour}h)${endColour} ${greenColour}Panel de ayuda${endColour}\n"
}

if [ $# -eq 0 ]; then
	mostrar_ayuda
	exit 1
fi

while getopts "bs:h" opcion; do
	case $opcion in
	b)
         bval="$OPTARG"
         echo  $bval
	 echo -e " ${greenColour}Hacer copia de seguridad de la base de datos${endColour}\n"



        # Nombre de usuario y base de datos MySQL
          usuario_mysql=$bval
          base_de_datos=$bval
          contrasena_mysql=$bval

	  tmpfile=$(mktemp -q /tmp/dbbackup.XXXXXX.sql || exit 1)

	  tmpfiletgz=$(mktemp -q /tmp/dbbackup.XXXXXX.sql.tar.gz || exit 1)

 	# Hacer copia de seguridad de la base de datos con mysqldump
        mysqldump -u $usuario_mysql -p$contrasena_mysql $base_de_datos > $tmpfile

	tar -czvf $tmpfiletgz $tmpfile;
        rsync $tmpfiletgz clopez@backups.suratica.es:$destino



	;;

	s)
	bval="$OPTARG"
	echo $bval
         origen=$bval
         destino=$bval


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
